package it.uniupo.giiot.backend.comms;

import com.google.gson.*;
import com.google.gson.reflect.TypeToken;
import com.google.gson.stream.JsonReader;
import com.google.gson.stream.JsonToken;
import com.google.gson.stream.JsonWriter;
import it.uniupo.giiot.backend.core.IntegerPkEntity;
import it.uniupo.giiot.backend.tool.DaoException;
import it.uniupo.giiot.backend.tool.HibernateUtil;

import java.io.IOException;
import java.lang.reflect.Type;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZoneOffset;

/**
 * Factory per creare un'instanza di Json con i type-adapter aware della Session di Hibernate.
 *
 * @author Riccardo Paolo Bestetti
 */
public class GsonInstanceFactory {
    private GsonInstanceFactory() {
    }

    /**
     * Crea un'istanza di Gson.
     * @see GsonInstanceFactory
     */
    public static Gson create() {
        return new GsonBuilder()
                .excludeFieldsWithoutExposeAnnotation()
                .registerTypeAdapter(LocalDateTime.class,
                        (JsonDeserializer<LocalDateTime>) (json, type, jsonDeserializationContext) ->
                        {
                            Instant instant = Instant.ofEpochSecond(json.getAsJsonPrimitive().getAsLong());
                            return LocalDateTime.ofInstant(instant, ZoneId.of("UTC"));
                        })
                .registerTypeAdapter(LocalDateTime.class,
                        (JsonSerializer<LocalDateTime>) (obj, type, jsonSerializationContext) ->
                                new JsonPrimitive(obj.toEpochSecond(ZoneOffset.UTC))
                )
                .registerTypeAdapterFactory(new TypeAdapterFactory() {
                    @Override
                    public <T> TypeAdapter<T> create(Gson gson, TypeToken<T> type) {
                        final Type t = type.getType();
                        if (!t.getClass().isAssignableFrom(Class.class))
                            return null;
                        final Class<?> c = (Class<?>) t;
                        final TypeAdapter<T> delegate = gson.getDelegateAdapter(this, type);

                        // filtra il tipo passato: se non è una delle nostre entità, ritorna null
                        if (!IntegerPkEntity.class.isAssignableFrom(c))
                            return null;

                        return new TypeAdapter<T>() {
                            @Override
                            public void write(JsonWriter out, T value) throws IOException {
                                delegate.write(out, value);
                            }

                            @Override
                            public T read(JsonReader in) throws IOException {
                                JsonToken next = in.peek();
                                if (next == JsonToken.NUMBER) {
                                    try {
                                        int pk = in.nextInt();
                                        // safety: il cast è garantito dal filtraggio dei tipi a monte
                                        @SuppressWarnings("unchecked")
                                        T result = (T) HibernateUtil.getWithIntegerPk(HibernateUtil.getCurrentSession(), c, pk);
                                        return result;
                                    } catch (IllegalStateException | NumberFormatException | DaoException e) {
                                        if (in.isLenient())
                                            in.skipValue();
                                        else
                                            throw new IOException("JSON parsing error", e);
                                        return null;
                                    }
                                } else {
                                    return delegate.read(in);
                                }
                            }
                        };
                    }
                })
                .create();
    }
}
