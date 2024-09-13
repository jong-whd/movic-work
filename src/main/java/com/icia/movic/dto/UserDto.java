package com.icia.movic.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserDto {
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
