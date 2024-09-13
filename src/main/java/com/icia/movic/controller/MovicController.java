package com.icia.movic.controller;

import com.icia.movic.dto.BookMarkDto;
import com.icia.movic.dto.MovicDto;
import com.icia.movic.dto.PaymentDto;
import com.icia.movic.dto.UserDto;
import com.icia.movic.service.MovicService;
import com.icia.movic.service.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.util.List;


@Controller
@Slf4j
public class MovicController {
    @Autowired
    private UserService uServ;
    @Autowired
    private MovicService mServ;
    private Object boardService;


    @GetMapping("/")
    public String index(Model model) {
        return "login";
    }
    @GetMapping("home")
    public String home(Integer pageNum,
                       String keyword,
                       String m_genre,
                       Model model,
                       HttpSession session){
        log.info("home() k : {} {}", keyword ,m_genre);

        mServ.getMovic(pageNum, keyword, m_genre, model,session);
        return "index";
    }

//    @GetMapping("/")
//    public String home (Integer pageNum,
//                        String keyword, Model model){
//        log.info("home() k : {}", keyword );
//
//        mServ.getMovic(pageNum, keyword, model);
//        return "index";
//    }//home end

    @GetMapping("saveForm")
    public String saveForm(){
        log.info("saveForm()");
        return "saveForm";
    }//saveForm end

    @PostMapping("saveProc")
    public String saveProc(@RequestPart List<MultipartFile> files, MovicDto movic,
                           HttpSession session, RedirectAttributes rttr){
        log.info("saveProc()");
        String view = mServ.saveMovic(files, movic, session, rttr);
        return "redirect:/admain";
    }

    @GetMapping("updateForm")
    public String updateForm(Integer m_code, Model model){
        log.info("updateForm()");
        mServ.getMovic(m_code, model);
        return "updateForm";
    }
    @PostMapping("updateProc")
    public String updateProc(@RequestPart List<MultipartFile> files,
                             MovicDto movic,
                             HttpSession session,
                             RedirectAttributes rttr){
        log.info("updateProc()");
        String view = mServ.updateMovic(files, movic, session, rttr);
        return view;
    }

    @GetMapping("streamingPage")
    public String streamingPage(Integer m_code, Model model){
        log.info("streamingPage()");
        mServ.getMovic(m_code, model);
        return "streamingPage";
    }

    @GetMapping("delete")
    public String delete(Integer m_code,
                         HttpSession session,
                         RedirectAttributes rttr){
        log.info("delete()");
        String view = mServ.deleteMovic(m_code, session, rttr);
        return view;
    }
    @GetMapping("download")
    public ResponseEntity<Resource> download(Integer m_code,
                                             HttpSession session) throws IOException {
        log.info("download()");
        ResponseEntity<Resource> resp = mServ.fileDownload(m_code, session);
        return resp;
    }


    //북마크 페이지로 이동
    @GetMapping("bookmark")
    public String bookmark(String uid,Model model){
        log.info("bookmark()");
        mServ.getBookMark(uid,model);
        return "bookmark";
    }

    //북마크 기능 구현
    @GetMapping("saveBookMark")
    @ResponseBody
    public String saveBookMark(BookMarkDto bookmark){
        log.info("saveBookMark()");
        String res = mServ.saveBookMark(bookmark);
        return res;
    }

    //북마크 삭제
    @GetMapping("bookmarkDelete")
    public String bookmarkDelete(@RequestParam("bcodes") List<Integer> bcodes,
                                 HttpSession session){
        log.info("bookmarkDelete() : {}", bcodes);
        String view = mServ.deleteBookMark(bcodes, session);
        return view;
    }

    //회원가입 및 아이디,비밀번호 찾기
    @GetMapping("join2")
    public String join2(){
        log.info("join2");
        return "join2";
    }

    @PostMapping("search")
    public String search(Model model) {
        log.info("search");
        return null;
    }

    @PostMapping("signup")
    public String signUpProc(UserDto user,
                             HttpSession session,
                             RedirectAttributes rttr) {
        log.info("signUpProc");
        uServ.signup(user, session, rttr);
        return "redirect:/";
    }

    @PostMapping("idCheck")
    @ResponseBody
    public String idCheck(String uid) {
        log.info("idCheck() : uid - {}", uid);
        String res = uServ.checkId(uid);
        return res;
    }

    @GetMapping("searchId")
    public String searchId(){
        log.info("searchId()");
        return "searchId";
    }
    @PostMapping("idfocus")
    @ResponseBody
    public String idfocus(UserDto user){
        log.info("idfocus()");
        String uid = uServ.focusId(user);
        return uid;//uid
    }

    @GetMapping("login")
    public String login(){
        log.info("login()");
        return "login";
    }

    @ResponseBody
    @PostMapping ("loginProc")
    public String loginProc(UserDto user,
                            HttpSession session,
                            RedirectAttributes rttr){
        String msg = null;
        log.info("loginProc() : id - {}, pass - {}",
                user.getUid(), user.getUpass());
        msg = uServ.loginProc(user.getUid(),user.getUpass(),session);
        return msg;//
    }
    @GetMapping("logout")
    public String logout(HttpSession session){
        log.info("logout()");
        session.invalidate();
        return "redirect:/";
    }
    @GetMapping("admain")
    public String admain(Integer menu,Integer pageNum, String keyword,Model model){
        log.info("admain()");
        uServ.makeForm(menu,model);
        uServ.getUser(menu,pageNum, keyword, model);
        return "admain";
    }

    @GetMapping("mypage")
    public String mypage(){
        log.info("mypage()");
        return "mypage";
    }

    // login 페이지 css(login.css),searchId(아이디 찾기)페이지 css(searchid.css), mymovie(나의 결제 페이지) css(movie.css)
    //결제 페이지
    @GetMapping("payment")
    public String payment(PaymentDto payment,
                          RedirectAttributes rttr){
        log.info("payment()");
        String view = mServ.payMovie(payment, rttr);
        return view;
    }
}
