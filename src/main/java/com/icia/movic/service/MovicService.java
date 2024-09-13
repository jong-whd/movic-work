package com.icia.movic.service;

import com.icia.movic.dao.MovicDao;
import com.icia.movic.dto.BookMarkDto;
import com.icia.movic.dto.MovicDto;
import com.icia.movic.dto.PaymentDto;
import com.icia.movic.util.PagingPay;
import com.icia.movic.util.PagingUtil;
import jakarta.servlet.http.HttpSession;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.InputStreamResource;
import org.springframework.core.io.Resource;
import org.springframework.http.CacheControl;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Slf4j

public class MovicService {
    @Autowired
    private MovicDao mDao;

    private int listCnt = 9; //한페이지당 9개를 출력함
    private String listTemp;
    private int listCnt1 = 12;

    //영화 전체 목록 가져오는 메소드
    public String getMovic(Integer pageNum, String keyword, Model model) {
        log.info("getMovic()");

        if (pageNum == null) {
            pageNum = 1;
        }

        //페이징 처리용 데이터 설정. limit 부분에 설정되게 함.
        Map<String, Object> map = new HashMap<>();
        map.put("pageNum", (pageNum - 1) * listCnt);
        map.put("listCnt", listCnt);
        map.put("keyword", keyword);

        //DB에서 영화정보 목록 가져오기
        List<MovicDto> movietbl = mDao.selectMovicList(map);

        map.put("pageNum", pageNum);
        String pageHtml = getPaging(map);


        model.addAttribute("mlist", movietbl);
        model.addAttribute("paging",pageHtml);


        return "main";

    }//getMovicList end

    private String getPaging(Map<String, Object> map) {
        String pageHtml = null;

        //전체 데이터 개수
        int maxNum = mDao.selectMovicCnt(map);

        //한 페이지 당 페이지 번호 개수
        int pageCnt = 5;

        PagingUtil paging = new PagingUtil(maxNum, (int)map.get("pageNum"), listCnt, pageCnt, (String) map.get("listName"));
        pageHtml = paging.makePaging();
        return pageHtml;
    }//getPaging end

    // 영화등록
    public String saveMovic(List<MultipartFile> files,
                            MovicDto movic,
                            HttpSession session,
                            RedirectAttributes rttr) {
        log.info("saveMovic");

        String msg = null;
        String view = null;

        try {
            if (!files.get(0).isEmpty()) {
                fileUpload(files, session, movic);
            }
            mDao.insertMovic(movic);
            msg = "저장 성공";
            view = "redirect:/";
        } catch (Exception e) {
            e.printStackTrace();
            msg = "저장 실패";
            view = "redirect:saveForm";
        }
        rttr.addFlashAttribute("msg", msg);
        return view;
    }// saveMovic end

    private void fileUpload(List<MultipartFile> files,
                            HttpSession session,
                            MovicDto movic) throws IOException {
        log.info("fileUpload");
        String sysname = null;
        String oriname = null; // 원래 파일명

        String realPath = session.getServletContext().getRealPath("/");
        log.info(realPath);
        realPath += "upload/";
        File folder = new File(realPath);
        if (folder.isDirectory() == false) {
            folder.mkdir();
        }

        MultipartFile mf = files.get(0);
        oriname = mf.getOriginalFilename(); // 원래 파일명
        // 변경할 이름에는 밀리초 값을 사용
        sysname = System.currentTimeMillis() +
                oriname.substring(oriname.lastIndexOf("."));

        File file = new File(realPath + sysname);

        mf.transferTo(file);

        movic.setP_sysname(sysname);
        movic.setP_oriname(oriname);
    }//fileUpload end

    public void getMovic(Integer m_code, Model model) {
        log.info("getMovic()");
        MovicDto movie = mDao.selectMovic(m_code);
        model.addAttribute("movic", movie);
    }// getMovic end

    public String updateMovic(List<MultipartFile> files,
                              MovicDto movie,
                              HttpSession session,
                              RedirectAttributes rttr) {
        log.info("updateMovic()");
        String msg = null;
        String view = null;
        String poster = movie.getP_sysname();

        try {
            if (!files.get(0).isEmpty()) {
                fileUpload(files, session, movie);
            }
            mDao.updateMovic(movie);

            if (poster != null && !files.get(0).isEmpty()){
                fileDeletes(poster, session);
            }
            msg = "수정 성공";
            view = "redirect:detail?m_code=" + movie.getM_code();
        }  catch (Exception e) {
            e.printStackTrace();
            msg = "수정 실패";
            view = "redirect:updateForm?m_code=" + movie.getM_code();
        }
        rttr.addFlashAttribute("msg", msg);
        return view;
    }//updateMovic end

    private void fileDeletes(String poster,
                             HttpSession session)
            throws Exception{
        log.info("fileDelete()");
        String realPath = session.getServletContext().getRealPath("/");
        realPath += "upload/" + poster;
        File file = new File(realPath);
        if (file.exists()){
            file.delete();
        }
    }//fileDeletes end

    public String deleteMovic(Integer m_code,
                              HttpSession session,
                              RedirectAttributes rttr) {
        log.info("deleteMovic");
        String msg = null;
        String view = null;

        MovicDto movie = mDao.selectMovic(m_code);
        String poster = movie.getP_sysname();

        try {
            if (poster != null){
                fileDeletes(poster, session);
            }
            mDao.deleteMovic(m_code);
            msg = "삭제 성공";
            view = "redirect:/";
        } catch (Exception e) {
            e.printStackTrace();
            msg = "삭제 실패";
            view = "redirect:detail?m_code=" + m_code;
        }
        rttr.addFlashAttribute("msg", msg);
        return view;
    }//deleteMovic end

    public ResponseEntity<Resource> fileDownload(Integer m_code,
                                                 HttpSession session)
            throws IOException {
        log.info("fileDownlod()");
        MovicDto movie = mDao.selectMovic(m_code);
        String sysname = movie.getP_sysname();
        String oriname = movie.getP_oriname();

        String realPath = session.getServletContext().getRealPath("/");
        realPath += "upload/" + sysname;

        InputStreamResource fResource = new InputStreamResource(new FileSystemResource(realPath));

        String fileName = URLEncoder.encode(oriname, "UTF-8");

        return ResponseEntity.ok().contentType(MediaType.APPLICATION_OCTET_STREAM)
                .cacheControl(CacheControl.noCache())
                .header(HttpHeaders.CONTENT_DISPOSITION,"attachment; filename=" + fileName)
                .body(fResource);

    }//fileDownload end

    //북마크 기능 구현
    public void getBookMark(String uid, Model model) {
        List<BookMarkDto> bList=mDao.selectBookMarkList(uid);
        model.addAttribute("bList", bList);
    }

    public String saveBookMark(BookMarkDto bookmark) {
        String res = null;
        try {
            mDao.insertBookMark(bookmark);
            res = "ok";
        }catch (Exception e){
            e.printStackTrace();
            res = "fail";
        }
        return res;
    }

    public String deleteBookMark(List<Integer> bcodes, HttpSession session) {
        String view = null;
        String uid = "user01"; //session에서 아이디 꺼내기
        try {
            for (int b : bcodes){
                mDao.deleteBookMark(b);
            }

        }catch (Exception e){
            e.printStackTrace();
        }
        view = "redirect:bookmark?uid="+uid;
        return view;
    }

    //결제 페이지
    public String payMovie(PaymentDto payment,
                           RedirectAttributes rttr) {
        log.info("payMovie()");

        String msg = null;
        String view = null;

        try {
            mDao.insertPayment(payment);
            msg = "결제 성공";
            view = "redirect:mymovie";
        }catch (Exception e){
            e.printStackTrace();
            msg = "결제 실패";
            view = "redirect:payment";
        }
        rttr.addFlashAttribute("msg", msg);
        return view;
    }
    //결제된 나의 영화 페이지
    public String getMyMovie(Integer pageNumber,
                             Model model,
                             HttpSession session) {
        log.info("getMyMovie()");

        if(pageNumber == null){
            pageNumber = 1;
        }

        Map<String, Integer> pmap = new HashMap<>();
        pmap.put("pageNum1", (pageNumber - 1) * listCnt1);
        pmap.put("listCnt1", listCnt1);

        List<PaymentDto> pList = mDao.selectPayList(pmap);
        model.addAttribute("pList", pList);

        String pageHtml = payPaging(pageNumber);
        model.addAttribute("paging1",pageHtml);

        session.setAttribute("pageNum1", pageNumber);
        return "mymovie";
    }
    private String payPaging(Integer pageNum1) {
        String pageHtml = null;
        //전체 데이터 개수
        int maxNum1 = mDao.cntpayMovie();
        //한 페이지 당 페이지 번호 개수
        int pageCnt1 = 5;

        PagingPay paging1 =
                new PagingPay(maxNum1, pageNum1, listCnt1, pageCnt1);
        pageHtml = paging1.payPaging();

        return pageHtml;
    }

    public void getMovic(Integer pageNum,
                         String keyword,
                         String m_genre,
                         Model model,
                         HttpSession session) {
        log.info("getMovic()" + pageNum + keyword);

        if (pageNum == null) {
            pageNum = 1;
        }

        Map<String, Object> map = new HashMap<>();
        map.put("pageNum", (pageNum - 1) * listCnt);
        map.put("listCnt", listCnt);
        map.put("keyword", keyword);
        map.put("genre", m_genre);
        listTemp = "./main?";
        if (keyword != null && keyword != "") {
            listTemp += "keyword=" + keyword;
            if (m_genre != null && m_genre != "") {
                listTemp += "&m_genre=" + m_genre + "&";
            } else {
                listTemp += "&";
            }
        } else {
            if (m_genre != null && m_genre != "") {
                listTemp += "m_genre=" + m_genre + "&";
            }
        }
    }
}//class end
