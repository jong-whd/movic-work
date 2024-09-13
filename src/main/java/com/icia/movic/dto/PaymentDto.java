package com.icia.movic.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PaymentDto {
    private int p_code;
    private String p_id;
    private int p_payment;
    private String p_sysname;
    private String m_title;
}
