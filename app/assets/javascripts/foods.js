document.addEventListener("DOMContentLoaded", function () {
  document.body.addEventListener("ajax:success", function (event) {
    var detail = event.detail;
    var data = detail[0], status = detail[1], xhr = detail[2];

    // Ajaxリクエストが成功したときに呼ばれる処理
    if (data.count !== undefined) {
      // 成功時の処理: いいね数を更新
      var foodId = xhr.getResponseHeader("X-Food-ID");
      var likeCountElement = document.querySelector("#like-count-" + foodId);
      if (likeCountElement) {
        likeCountElement.innerText = "❤︎" + data.count;
      }
    }
  });
});
