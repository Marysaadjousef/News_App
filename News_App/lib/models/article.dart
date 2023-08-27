
    class Article {
      final String urlToImage;
      final String content;
      final String title;
      Article(
          {required this.urlToImage, required this.content, required this.title});

      static List<Article> convertToArticles(List articles) {
        List<Article> articlesList = [];
        for (var article in articles) {
          if(article["urlToImage"]==null||article["content"]==null||article["title"]==null){
            continue;
          }
          articlesList.add(Article(
              urlToImage: article["urlToImage"],
              content: article["content"],
              title: article["title"]));
        }
        return articlesList;
      }
    }
