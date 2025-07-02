let replyService = (function() {

    function add(reply, callback = null, error = null) {
        console.log("add reply...........");

        $.ajax({
            type: 'post',
            url: '/replies/new',
            data: JSON.stringify(reply), // reply(js객체)-> json으로 변환
            contentType: "application/json; charset=utf-8",

            success: function(result, status, xhr) {
                if (callback) {
                    callback(result);
                }
            },

            error: function(xhr, status, er) {
                if (error) {
                    error(er);
                } else {
                    console.error("댓글 등록 실패:", er);
                }
            }
        });
    }

    function getList(param, callback, error) {
        let boardid = param.boardid; // bno에서 boardid로 변경
        let page = param.page || 1;

        $.ajax({
            type: 'get',
            url: '/replies/pages/' + boardid + "/" + page, // bno에서 boardid로 변경

            success: function(result, status, xhr) {
                if (callback) {
                    callback(result.replyCnt, result.list);
                }
            },

            error: function(xhr, status, er) {
                if (error) {
                    error(er);
                } else {
                    console.error("댓글 목록 로드 실패:", er);
                }
            }
        });
    }

    function remove(rno, callback = null, error = null) {
        $.ajax({
            type: 'delete',
            url: '/replies/' + rno,

            success: function(deleteResult, status, xhr) {
                if (callback) {
                    callback(deleteResult);
                }
            },

            error: function(xhr, status, er) {
                if (error) {
                    error(er);
                } else {
                    console.error("댓글 삭제 실패:", er);
                }
            }
        });
    }

    function get(rno, callback = null, error = null) {
        $.ajax({
            type: 'get',
            url: '/replies/' + rno,

            success: function(result, status, xhr) {
                if (callback) {
                    callback(result);
                }
            },

            error: function(xhr, status, err) {
                if (error) {
                    error(err);
                } else {
                    console.error("댓글 조회 실패:", err);
                }
            }
        });
    }

    function update(reply, callback = null, error = null) {
        $.ajax({
            type: 'put',
            url: '/replies/' + reply.rno,
            data: JSON.stringify(reply),
            contentType: "application/json; charset=utf-8",

            success: function(result, status, xhr) {
                if (callback) {
                    callback(result);
                }
            },

            error: function(xhr, status, err) {
                if (error) {
                    error(err);
                } else {
                    console.error("댓글 수정 실패:", err);
                }
            }
        });
    }

    function displayTime(timeValue) {
        let today = new Date();
        let gap = today.getTime() - timeValue;
        
        let dateObj = new Date(timeValue);
        let str = "";

        if (gap < (1000 * 60 * 60 * 24)) {
            let hh = dateObj.getHours() + 9;  // 시간대 차이를 고려하여 9시간 더함 (한국 시간 기준)
            let mi = dateObj.getMinutes();
            let ss = dateObj.getSeconds();

            return [
                (hh > 9 ? '' : '0') + hh, ":",
                (mi > 9 ? '' : '0') + mi, ":",
                (ss > 9 ? '' : '0') + ss
            ].join('');
        } else {
            let yy = dateObj.getFullYear();
            let mm = dateObj.getMonth() + 1;
            let dd =  dateObj.getDate();

            return [
                yy, '/', (mm > 9 ? '' : '0') + mm, '/', (dd > 9 ? '' : '0') + dd
            ].join('');
        }
    }

    return {
        add: add,
        getList: getList,
        remove: remove,
        get: get,
        update: update,
        displayTime: displayTime
    };

})();
