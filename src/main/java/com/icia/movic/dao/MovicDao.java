package com.icia.movic.dao;

import com.icia.movic.dto.BookMarkDto;
import com.icia.movic.dto.MovicDto;
import com.icia.movic.dto.PaymentDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

@Mapper
public interface MovicDao {

    void insertMovic();
    void selectMovic();


    List<MovicDto> selectMovicList(Map<String, Object> map);
    void insertMovic(MovicDto movie);
    MovicDto selectMovic(Integer m_code);
    int selectMovicCnt(Map<String, Object> map);

    void updateMovic(MovicDto movie);

    void deleteMovic(Integer m_code);

    void insertBookMark(BookMarkDto bookmark);

    List<BookMarkDto> selectBookMarkList(String uid);

    void deleteBookMark(Integer b_code);

    void insertPayment(PaymentDto payment);

    @Select("select count(*) from paymenttbl")
    int cntpayMovie();

    List<PaymentDto> selectPayList(Map<String, Integer> pmap);
}



