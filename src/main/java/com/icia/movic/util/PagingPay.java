package com.icia.movic.util;

import lombok.AllArgsConstructor;

@AllArgsConstructor
public class PagingPay {
    private int maxNum1;//전체 데이터 개수
    private int pageNum1;//현재 페이지 번호
    private int listCnt1;//페이지 당 보여질 데이터 개수
    private int pageCnt1;//화면 당 페이지 번호 개수

    //페이지용 html 코드를 만드는 메소드
    public String payPaging(){
        String pageStr = null;
        StringBuffer sb = new StringBuffer();

        //1. 전체 페이지 개수 구하기 : maxNum 11, listCnt 5 -> 3페이지
        int totalPage = (maxNum1 % listCnt1) > 0 ?
                (maxNum1 / listCnt1) + 1 : //나머지가 있으면 1페이지 추가
                maxNum1 / listCnt1;
        //2. 현재 페이지가 속해 있는 그룹 번호 구하기
        int curGroup = (pageNum1 % pageCnt1) > 0 ?
                (pageNum1 / pageCnt1) + 1 :
                pageNum1 / pageCnt1;

        //3. 현재 보이는 페이지 그룹의 시작 번호 구하기
        int start = (curGroup * pageCnt1) - (pageCnt1 -1);
        //4. 현재 보이는 페이지 그룹의 마지막 번호 구하기
        int end = (curGroup * pageCnt1) >= totalPage ?
                totalPage : curGroup * pageCnt1;

        //이전 버튼 처리
        if(start != 1){
            sb.append("<a class='pno' href='mymovie?pageNumber=" + (start - 1) + "'>");
            sb.append("◁</a>");
        }//<a class='pno' href='./?pageNum=3'>◀</a>

        //중간 페이지 번호 버튼 처리
        for(int i = start; i <= end; i++){
            if (i != pageNum1){//현재 페이지가 아닌 번호
                sb.append("<a class='pno' href='mymovie?pageNumber=" + i + "'>");
                sb.append(i + "</a>");
                //<a class='pno' href='./?pageNum=4'>4</a>
            }else {//현재 보이는 페이지 번호
                sb.append("<font class='pno'>");
                sb.append(i + "</font>");
                //<font class='pno'>5</font>
            }

        }
        //다음 버튼 처리
        if (end != totalPage){
            sb.append("<a class='pno' href='mymovie?pageNumber=" + (end + 1) + "'>");
            sb.append("▷</a>");
        }//<a class='pno' href='./?pageNum=7'>▶</a>

        //StringBuffer에 저장된 내용을 문자열로 변환
        pageStr = sb.toString();

        return pageStr;
    }

}
