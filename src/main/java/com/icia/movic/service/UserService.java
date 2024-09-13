package com.icia.movic.service;

import com.icia.movic.dao.UserDao;
import com.icia.movic.dto.MovicDto;
import com.icia.movic.dto.PaymentDto;
import com.icia.movic.dto.UserDto;
import com.icia.movic.util.PagingUtil;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

@Service
@Slf4j
public class UserService {
    @Autowired
    private UserDao uDao;

    int listCnt = 10;
    public void signup(UserDto user,
                       HttpSession session,
                       RedirectAttributes rttr) {
        log.info("signup");
        uDao.insertUser(user);

    }


    public String checkId(String uid) {
        String res = null;
        if(uDao.checkId(uid)==0){
            res = "ok";
        }
        return res;
    }
    public String focusId(UserDto user) {
        log.info("focusId");
        String uid = uDao.selectId(user);
        return uid;

    }

    public String loginProc(String uid,
                            String upass,
                            HttpSession session) {
        UserDto nowUser = null;

        String msg = null;
        log.info("loginProc");

        nowUser = uDao.loginCheck(uid);

        log.info("nowUser: " + nowUser);

        if (nowUser == null) {
            msg = "아이디가 존재하지 않습니다.";
        } else if (!Objects.equals(upass, nowUser.getUpass())) {
            msg = "비밀번호가 일치하지 않습니다.";
        } else if (upass.equals(nowUser.getUpass())) {
            msg = "ok";
            if(nowUser.getUisadmin() == 1){
                msg = "admin";
            }
            session.setAttribute("nowUser", nowUser);//nowUser는 사용자 ID
        }

        log.info(msg);
        return msg;
    }

    public void makeForm(Integer menu, Model model) {
        String res = null;
        if(menu==null){
            return;
        }
        switch (menu){
            case 1:
                res = "saveForm";
                break;
            case 2:

                break;
            case 3:

                break;
            case 4:
                res = "memberManageForm";
                break;
            case 5:
                res = "adminPayment";
                break;
        }
        model.addAttribute("nowMenu",res);

    }
    public void getUser(Integer menu, Integer pageNum, String keyword, Model model) {
        String pageHtml = null;
        log.info("getUser()");
        if(menu==null){
            return;
        }
        if (pageNum == null) {
            pageNum = 1;
        }

        Map<String, Object> map = new HashMap<>();
        map.put("pageNum", (pageNum - 1) * listCnt);
        map.put("listCnt", listCnt);
        map.put("keyword", keyword);
        map.put("listName", "./admain?menu=" + menu + "&");
        map.put("menu", menu);

        switch (menu){
            case 1:
            case 2:
            case 3:
            case 4:
                List<UserDto> userList = uDao.getuserList(map);
                map.put("pageNum", pageNum);
                pageHtml = getPaging(map);
                model.addAttribute("uList", userList);
                break;
            case 5:
                List<PaymentDto> payList = uDao.getuserpayList(map);
                map.put("pageNum", pageNum);
                pageHtml = getPagingPayList(map);
                model.addAttribute("pList", payList);
                break;
        }




        model.addAttribute("paging", pageHtml);

    }

    private String getPaging(Map<String, Object> map) {
        String pageHtml = null;
        log.info("map={}", map);
        int maxNum = uDao.selectUserCnt(map);
        int pageCnt = 5;

        PagingUtil paging =
                new PagingUtil(maxNum, (int)map.get("pageNum"), listCnt, pageCnt
                        ,(String)map.get("listName"));
        pageHtml = paging.makePaging();

        return pageHtml;
    }

    private String getPagingPayList(Map<String, Object> map) {
        String pageHtml = null;
        log.info("map={}", map);
        int maxNum = uDao.selectUserCntPL(map);
        int pageCnt = 5;

        PagingUtil paging =
                new PagingUtil(maxNum, (int)map.get("pageNum"), listCnt, pageCnt
                        ,(String)map.get("listName"));
        pageHtml = paging.makePaging();

        return pageHtml;
    }
}
