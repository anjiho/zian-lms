package com.zianedu.lms.define.datasource;

import com.zianedu.lms.dto.SelectboxDTO;

import java.util.ArrayList;
import java.util.List;

public enum DeviceType {

    ALL(0, "전체"),
    PC(1, "PC"),
    MOBILE(3, "모바일")
    ;

    int deviceTypeKey;

    String deviceTypeStr;

    DeviceType(int deviceTypeKey, String deviceTypeStr) {
        this.deviceTypeKey = deviceTypeKey;
        this.deviceTypeStr = deviceTypeStr;
    }

    public static List<SelectboxDTO> getDeviceTypeSelectbox() {
        List<SelectboxDTO>list = new ArrayList<>();
        for (DeviceType deviceType : DeviceType.values()) {
            SelectboxDTO selectboxDTO = new SelectboxDTO(
                    deviceType.deviceTypeKey,
                    deviceType.deviceTypeStr
            );
            list.add(selectboxDTO);
        }
        return list;
    }

}
