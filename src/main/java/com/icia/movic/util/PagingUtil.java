    package com.icia.movic.util;

    import lombok.AllArgsConstructor;

    @AllArgsConstructor

    public class PagingUtil {
            private int maxNum; // 전체 데이터 개수
            private int pageNum; // 현재 페이지 번호
            private int listCnt; // 페이지 당 보여질 데이터 개수
            private int pageCnt; // 화면 당 페이지 번호 개수
            private String listName;



            // 페이징용 html 코드를 만드는 메소드
            public String makePaging(){
                String pageStr = null;
                String nowPage = "main";//현재 페이지명(임시)
                StringBuffer sb = new StringBuffer();

                // 1. 전체 페이지 개수 구하기 : maxNum이 11개, listCnt가 5개면 -> 3페이지
                int totalPage = (maxNum % listCnt) > 0 ?
                        (maxNum / listCnt) + 1 : maxNum / listCnt; // 데이터를 리스트 카운트로 나눈 후 나머지가 있으면 1페이지 추가

                // 2. 현재 페이지가 속해 있는 그룹 번호 구하기
                int curGroup = (pageNum % pageCnt) > 0 ?
                        (pageNum / pageCnt) + 1 :
                        pageNum / pageCnt;

                // 3. 현재 보이는 페이지 그룹의 시작 번호 구하기
                int start = (curGroup * pageCnt) - (pageCnt - 1);
                // 4. 현재 보이는 페이지 그룹의 마지막 번호 구하기
                int end = (curGroup * pageCnt) >= totalPage ?
                        totalPage : curGroup * pageCnt;

                // 이전 버튼 처리
                if (start != 1){
                    sb.append("<a class='pno' href='./"+listName+"?pageNum=" + (start - 1) + "'>");
                    sb.append("◀</a>");

                } // <a class='pno' href='./?pageNum=3'>◀</a>

                // 중간 페이지 번호 버튼 처리
                for (int i = start; i <= end; i++){
                    if (i != pageNum){// 현재 페이지가 아닌 번호
//                        sb.append("<a class='pno' href='./"+ nowPage+"?pageNum=" + i +
//                                "&keyword="+ (keyword==null?"":keyword) +
//                                "&m_genre=" + (genre==null?"":genre) + "'>");
                        sb.append("<a class='pno' href='"+ listName + "pageNum=" + i + "'>");
                        sb.append(i + "</a>");
                        // <a class='pno' href='./pageNum=4'>4</a> // start가 4라면
                    } else {// 현재 보이는 페이지 번호
                        sb.append("<font class='pno'>");
                        sb.append(i + "</font>");
                        // <font class='pno'>5</font>
                    }

                } // for end

                // 다음 버튼 처리
                if (end != totalPage){
//                    sb.append("<a class='pno' href='./"+nowPage+"?pageNum=" + (end + 1) +
//                            "&keyword="+ (keyword==null?"":keyword) +
//                            "&m_genre=" + (genre==null?"":genre) + "'>");
                    sb.append("<a class='pno' href='"+ listName + "pageNum=" + (end + 1) + "'>");
                    sb.append("▶</a>");
                } // <a class='pno' href='./?pageNum=7'>▶</a>

                //StringBuffer에 저장된 내용을 문자열로 변환
                pageStr = sb.toString();

                return pageStr;
            } //makePaging end

    }//class end

    // @AllArgConstructor
    // 모든 멤버 변수를 초기화하기 위해 값을 받는 생성자를 자동으로 작성해 주는 lombok 어노테이션