package com.zianedu.lms.utils;

import com.google.gson.*;

public class GsonUtil {

    public static JsonObject conertStringToJsonObj(String jsonStr) {
        if (jsonStr == null || "".equals(jsonStr)) return null;
        JsonParser parser = new JsonParser();
        JsonElement element = parser.parse(jsonStr);
        JsonObject object = element.getAsJsonObject();
        return object;
    }
}
