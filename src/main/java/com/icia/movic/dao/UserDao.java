package com.icia.movic.dao;

import com.icia.movic.dto.MovicDto;
import com.icia.movic.dto.PaymentDto;
import com.icia.movic.dto.UserDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface UserDao {
    void insertUser(UserDto user);

    int checkId(String uid);

    String selectId(UserDto user);

    UserDto loginCheck(String uid);

//    void insertMovic(MovicDto movietbl);
    List<UserDto> getuserList(Map<String, Object> map);

    int selectUserCnt(Map<String, Object> map);

    List<PaymentDto> getuserpayList(Map<String, Object> map);

    int selectUserCntPL(Map<String, Object> map);
}
