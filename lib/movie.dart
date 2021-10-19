
import 'package:flutter/material.dart';
import 'dataModel/dataModel.dart';

class MovieList extends StatelessWidget {

  final List<MovieData> movieList = MovieData.getMovies();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Movie List"),
        backgroundColor: Colors.grey.shade800,
      ),
      backgroundColor: Colors.grey.shade800,
      body: ListView.builder(
        itemCount: movieList.length,
        itemBuilder: (BuildContext context, int index){

          return Stack(
            children: <Widget>[
              movieCard(movieList[index], context),

              Positioned(
                top: 10.0,
                child: movieImage(movieList[index].images[0]))
            ],
          );
          // return Card(
          //   elevation: 12.0,
          //   color: Colors.blue.shade200,
          //   child: ListTile(
          //     title: Text(movieList[index].title),
          //     subtitle: Text("Hello!!"),
          //     leading: CircleAvatar(
          //       child: Container(
          //         height: 200,
          //         width: 200,
          //         decoration: BoxDecoration(
          //           image: DecorationImage(
          //             image: NetworkImage(movieList[index].images[0],),
          //             fit: BoxFit.cover,
          //           ),
          //           borderRadius: BorderRadius.circular(13.9)
          //         ),
          //       ),
          //     ),
              
          //     onTap: (){
          //       Navigator.push(context, MaterialPageRoute(
          //         builder: (context) => MovieListDetails(movieName: movieList[index].title)));
          //     },
          //   ),
          // );

        }
      )
    );

  }
  
  Widget movieCard(MovieData movie, BuildContext context){
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(
          left: 62.0
        ),
        width: MediaQuery.of(context).size.width,
        height: 120.0,
        child: Card(
          color: Colors.grey.shade600,
          
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0,
            bottom: 8.0,
            left: 54.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Text(movie.title, style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold
                      ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Text("Rating: ${movie.imbdRating} / 10", style: mainTextStyle()),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text("Released: ${movie.released}", style: mainTextStyle(),),
                    Text(movie.runtime, style: mainTextStyle()),
                    Text(movie.rated, style: mainTextStyle()),

                  ],
                )
              ],
            ),
          ),
        ),
      ),

      onTap: () => Navigator.push(context, MaterialPageRoute(
        builder: (context) => MovieListDetails(movieImage: movie.images[0], movie: movie,))),
    );
  }

  Widget movieImage(String imageUrl){
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(imageUrl ),
          fit: BoxFit.cover,      
        )
      ),
    );
  }

  TextStyle mainTextStyle(){
    return TextStyle(
      color: Colors.white,
      fontSize: 12,
      fontWeight: FontWeight.normal
    );
  }
}

class MovieListDetails extends StatelessWidget {
  final String movieImage;
  final MovieData movie;

  const MovieListDetails({Key? key, required this.movieImage, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie Details"),
        backgroundColor: Colors.grey.shade800,
      ),

      body: ListView(
        children: <Widget>[
          MovieDetailsThumbnail(thumbnail: movieImage),
          MovieDetailsHeaderWithPoster(moviePoster: movie),
          HorizontalLine(),
          MovieDetailsCast(movieCast: movie),
          HorizontalLine(),

          MovieExtraPosters(posters: movie.images)

        ],
      )
      // body: Container(
      //   child: Center(
      //     child: RaisedButton(
      //       child: Text("Go Back ${movieName}"),
      //       onPressed: () {
      //         Navigator.pop(context);
      //       },
      //     ),
      //   ),
      // ),
    );
  }
}

class MovieDetailsThumbnail extends StatelessWidget {
  final String thumbnail;

  const MovieDetailsThumbnail({Key? key, required this.thumbnail}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 190,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(thumbnail),
                  fit: BoxFit.cover
                ),
              ),
            ),
            Icon(Icons.play_circle_outline_outlined, size: 100,
              color: Colors.white
            ),
          ],
        ),

        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Color(0x00f5f5f5), Color(0xfff5f5f5)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
            )
          ),
          height: 80,
        )
      ],
      
    );
  }
}

class MovieDetailsHeaderWithPoster extends StatelessWidget {
  final MovieData moviePoster;

  const MovieDetailsHeaderWithPoster({Key? key, required this.moviePoster}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: <Widget>[
          MoviePoster(poster: moviePoster.images[0].toString()),
          SizedBox(width: 15,),
          Expanded(
            child: MovieDetailsHeader(movie: moviePoster  ,),
          )
        ],
      ),
    );
  }
}

class MoviePoster extends StatelessWidget {
  final String poster;

  const MoviePoster({Key? key, required this.poster}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var borderRadius = BorderRadius.circular(10);
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: ClipRRect(
          borderRadius: borderRadius,
          child: Container(
            width: MediaQuery.of(context).size.width / 4,
            height: 180,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(poster),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MovieDetailsHeader extends StatelessWidget {
  final MovieData movie;

  const MovieDetailsHeader({Key? key, required this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("${movie.year} . ${movie.genre}".toUpperCase(),
          style: TextStyle(
            color: Colors.green.shade400,
            fontSize: 16,
            fontWeight: FontWeight.w400
          ),
        ),
        Text(movie.title, style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 32,
        ),),

        Text.rich(
          TextSpan(
            style: TextStyle(
              fontSize: 13, fontWeight: FontWeight.w300,
            ),
            children: <TextSpan>[
              TextSpan(
                text: movie.plot,
              ),
              TextSpan(
                text: "More...",
                style: TextStyle(
                  color: Colors.indigo,
                )
              )
            ]
          ),
        ),
      ],
    );
  }
}

class MovieDetailsCast extends StatelessWidget {
  final MovieData movieCast;

  const MovieDetailsCast({Key? key, required this.movieCast}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MovieField(field: "Cast", value: movieCast.actor),
          MovieField(field: "Directors", value: movieCast.director),
          MovieField(field: "Awards", value: movieCast.award)
        ],
        
      ),
    );
  }
}

class MovieField extends StatelessWidget {
  final String field;
  final String value;

  const MovieField({Key? key, required this.field, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("$field : ", style: TextStyle(
            color: Colors.black38,
            fontSize: 12, fontWeight: FontWeight.w300,
          ),),
          Expanded(
            child: Text(value, style: TextStyle(
              color: Colors.black, 
              fontSize: 12,
              fontWeight: FontWeight.w300
            ),)
          )
        ],
      ),
    );
  }
}

class HorizontalLine extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: 0.5,
        color: Colors.grey,
      ),
    );
  }
}

class MovieExtraPosters extends StatelessWidget {
  final List<String> posters;

  const MovieExtraPosters({Key? key, required this.posters}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("More Movie Poster".toUpperCase(), style: TextStyle(
          color: Colors.black26,
          fontSize: 14
        ),),

        Container(
          height: 180,
          child: ListView.separated(
            scrollDirection: Axis.horizontal, 
            separatorBuilder: (context, index) => SizedBox(width: 8,), 
            itemCount: posters.length,
            itemBuilder: (context, index) => ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),

              child: Container(
                width: MediaQuery.of(context).size.width / 4,
                height: 160,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(posters[index]),
                    fit: BoxFit.cover
                  )
                ),
              )
            ),
          )
        )
      ]
    );
  }
}