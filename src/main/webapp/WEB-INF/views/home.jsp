<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script language="javascript">

        function goPopup(){
            var pop = window.open("/jusoPopup","pop","width=570,height=420, scrollbars=yes, resizable=yes");
        }

        function jusoCallBack(roadFullAddr){
                document.form.roadFullAddr.value = roadFullAddr;
        }

    </script>
    <style>
        /* 리스트 아이템 스타일 */
        .list-item {
            padding: 10px;
            border: 1px solid #ccc;
            margin-bottom: 5px;
            cursor: pointer;
        }
        /* 아이템 상세 정보 스타일 */
        .item-details {
            display: none;
            padding: 10px;
            background-color: #f5f5f5;
        }
        /* 삭제 버튼 스타일 */
        .delete-btn {
            margin-left: 10px;
            color: red;
            cursor: pointer;
        }
    </style>
    <title>주소 입력 샘플</title>
    </head>
<body>
    <form name="form" id="form" method="post">
        <input type="button" onClick="goPopup();" value="도로명 주소 검색"/>
            <div id="callBackDiv">
                <table>
                    <tr><td>도로명주소 전체</td><td><input type="text"  style="width:500px; background-color:#f5f5f5;" id="roadFullAddr"  name="roadFullAddr" readonly/></td></tr>
                </table>
            </div>
           <button type="button" onclick="saveItem()">저장</button>
           <button type="button" onclick="initInputBtn()">초기화</button>
    </form>
    <hr>
    <div class="expander">
      <div class="expander-header">
        <span class="expander-text">검색 결과</span>
        <span class="expander-icon" >▲</span>
      </div>
      <div class="expander-content" style="display: none;">
        <table>
          <tbody id="list-container">
            <%-- 여기에 items를 구성하는 jsp 코드 --%>
          </tbody>
        </table>
      </div>
    </div>


    <script type="text/javascript">
        function initInputBtn() {
            document.getElementById('roadFullAddr').value = '';
        }

        function saveItem() {
            const roadFullAddr = $('#roadFullAddr').val();
            if(roadFullAddr == '' || roadFullAddr == null) {
                alert("값을 입력해주세요");
                return;
            }
            console.log(roadFullAddr);

            $.ajax({
            url: '/item/save',
            type: 'POST',
            data: {roadFullAddr: roadFullAddr},
            success: function(response) {
                alert("저장 성공");
                document.getElementById('roadFullAddr').value = '';
            },
            error: function(xhr, status, error) {
                alert("저장 실패");
                }
            });
        }

       $(document).ready(function() {
         // Expander control의 클릭 이벤트 핸들러를 등록합니다.
         $('.expander-header').click(function() {
           // Expander control의 아이콘과 텍스트를 변경합니다.
           const icon = $(this).find('.expander-icon');
           icon.text(icon.text() === '▲' ? '▼' : '▲');
           $(this).siblings('.expander-content').toggle();

           // Expander control이 열린 경우에만 Ajax 요청을 보냅니다.
           if (icon.text() === '▼') {
             $.ajax({
               url: '/items',
               type: 'GET',
               success: function(response) {
                 // 성공적으로 응답받은 경우 list를 업데이트합니다.
                 const items = response;
                 console.log("items: "+items);
                 let tableHTML = '';

                 items.forEach(item => {
                 console.log(item.item_id);
                  tableHTML += "<tr>";
                        tableHTML += "<td>" + item.item_id + "</td>";
                        tableHTML += "<td>" + item.session_id + "</td>";
                        tableHTML += "<td>" + item.created_date + "</td>";
                        tableHTML += "<td>" + item.road_full_addr + "</td>";
                        tableHTML += "<td><button onclick='deleteItem(" + item.item_id + ")'>Delete</button></td>";
                        tableHTML += "</tr>";
                      });
                 $('#list-container').html(tableHTML);
               },
               error: function(xhr, status, error) {
                 // 오류가 발생한 경우 알림을 출력합니다.
                 console.log(error);
                 alert("오류가 발생했습니다.");
               }
             });
           }
         });
       });
       </script>

    </script>
</body>
</html>