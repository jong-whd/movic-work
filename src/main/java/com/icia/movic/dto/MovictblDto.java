package com.icia.movic.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MovictblDto {
    private int m_code;//일련번호
    private String m_title;//제목
    private String m_director;//감독
    private String m_nation;//국가
    private String m_language;//언어
    private String m_genre;//장르
    private String m_actor;//배우
    private String m_open;//개봉일
    private String m_synopsis;//줄거리
    private String p_sysname;//썸네일 주소
    private String v_sysname;//비디오 주소
}

//m_code int NOT NULL AUTO_INCREMENT PRIMARY KEY, -- 일련번호
//m_title varchar(100) NOT NULL,					-- 제목(name -> title)
//m_director varchar(50) NOT NULL,				-- 감독
//m_nation varchar(50) NOT NULL,					-- 국가
//m_language varchar(30) not null,				-- 언어
//m_genre varchar(100) NOT NULL,					-- 장르
//m_actor varchar(100) NOT NULL,					-- 배우
//m_open varchar(10) NOT NULL,					-- 개봉일
//m_synopsis varchar(2000) DEFAULT NULL,			-- 줄거리
//p_sysname varchar(50) DEFAULT null,				-- 썸네일 주소
//v_sysname varchar(50) default null				-- 비디오 주소