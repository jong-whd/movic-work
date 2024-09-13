package com.icia.movic.dto;


import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BookMarkDto {
    private int b_code;
    private String b_uid;
    private int b_mcode;
    private String m_title;
    private String p_sysname;

    @Getter
    @Setter
    public static class UserDto {
        private String uid;
        private String upass;
        private String uname;
        private int uage;
        private String uaddr;
        private char ugender;
        private String uregnum;
        private String uphonenum;
        private short uisadmin;
    }
}
