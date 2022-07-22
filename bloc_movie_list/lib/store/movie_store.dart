import 'package:mobx/mobx.dart';
import 'package:movie_list/model/movie_cast_model.dart';
import 'package:movie_list/model/movie_detail_model.dart';
import 'package:movie_list/model/movie_model.dart';
import 'package:movie_list/model/movie_video_model.dart';
import 'package:movie_list/services/movie_services.dart';

part 'movie_store.g.dart';

const String POPULAR = 'popular';
const String TOP_RATED = 'top_rated';
const String UPCOMING = 'upcoming';

class MovieStore = _MovieStoreBase with _$MovieStore;
MovieServices movieServices = MovieServices();

abstract class _MovieStoreBase with Store {
  //Temporarily comment - maybe it will be use in the future
  // static ObservableFuture<MovieModel> emptyMovieResponse =
  //     ObservableFuture.value(MovieModel());
  // @observable
  // ObservableFuture<MovieModel> fetchMovieFuture = emptyMovieResponse;

  // @computed
  // bool get hasResults =>
  //     fetchMovieFuture != emptyMovieResponse &&
  //     fetchMovieFuture.status == FutureStatus.fulfilled;

  @observable
  ObservableList<Result> allPopular = ObservableList<Result>();

  @observable
  ObservableList<Result> allTopRated = ObservableList<Result>();

  @observable
  ObservableList<Result> allUpcoming = ObservableList<Result>();
  @observable
  ObservableList<Result> allLatest = ObservableList<Result>();

  @observable
  ObservableList<Result> allSimilar = ObservableList<Result>();

  @observable
  ObservableList<Cast> allCast = ObservableList<Cast>();

  @observable
  ObservableList<MovieDetailModel> movieDetails =
      ObservableList<MovieDetailModel>();

  @observable
  ObservableList<String> videoKeys = ObservableList<String>();

  @observable
  String movieTypeFilter = POPULAR;

  @action
  String getImage(String img) {
    String url = "https://image.tmdb.org/t/p/w500/";

    return '$url$img';
  }

  @action
  ObservableList<Result> getMovieList(String movieType) {
    ObservableList<Result>? movies;

    switch (movieType) {
      case 'popular':
        movies = allPopular;
        break;
      case 'top rated':
        movies = allTopRated;
        break;
      case 'upcoming':
        movies = allUpcoming;
        break;
      default:
        movies = allPopular;
        break;
    }
    return movies;
  }

  @action
  addPopularMovies(MovieModel m) async {
    if (m.results!.isEmpty || m.results == null) {
      allPopular.clear();
    } else {
      for (var element in m.results!) {
        allPopular.add(element);
      }
      allPopular.sort(
        (a, b) {
          return b.releaseDate!.compareTo(a.releaseDate!);
        },
      );
    }
  }

  @action
  fetchPopular() async {
    MovieModel m = MovieModel();

    final future = movieServices.fetchMovie(POPULAR);

    m = await future;

    addPopularMovies(m);

    return;
  }

  @action
  addTopRatedMovies(MovieModel m) async {
    if (m.results!.isEmpty || m.results == null) {
      allTopRated.clear();
    } else {
      for (var element in m.results!) {
        allTopRated.add(element);
      }
      allTopRated.sort(
        (a, b) {
          return b.releaseDate!.compareTo(a.releaseDate!);
        },
      );
    }
  }

  @action
  fetchTopRated() async {
    MovieModel m = MovieModel();

    final future = movieServices.fetchMovie(TOP_RATED);

    m = await future;

    addTopRatedMovies(m);

    return;
  }

  @action
  addUpcomingMovies(MovieModel m) async {
    if (m.results!.isEmpty || m.results == null) {
      allUpcoming.clear();
    } else {
      for (var element in m.results!) {
        allUpcoming.add(element);
      }
      allUpcoming.sort(
        (a, b) {
          return b.releaseDate!.compareTo(a.releaseDate!);
        },
      );
    }
  }

  @action
  fetchUpcomingMovies() async {
    MovieModel m = MovieModel();

    final future = movieServices.fetchMovie(UPCOMING);

    m = await future;

    addUpcomingMovies(m);

    return;
  }

//Start - For fetching Movie Details
  @action
  addDetailsMovies(MovieDetailModel m) {
    if (movieDetails.isNotEmpty) {
      movieDetails.clear();
    } else {
      movieDetails.add(m);
    }
  }

  @action
  fetchDetailMovie(int id) async {
    MovieDetailModel m = MovieDetailModel();

    final future = movieServices.fetchMovieDetail(id);

    m = await future;

    addDetailsMovies(m);

    return;
  }
  //End - For fetching Movie Details

//Start - For fetching YT Videos
  @action
  addYoutubeVideo(MovieVideoModel m) {
    if (m.videoResults!.isEmpty || m.videoResults == null) {
      videoKeys.clear();
    } else {
      for (var element in m.videoResults!) {
        videoKeys.add("${element.key}");
      }
    }
  }

  @action
  fetchYoutubeVideo(int id) async {
    MovieVideoModel m = MovieVideoModel();

    final future = movieServices.getYoutubeId(id);

    m = await future;

    addYoutubeVideo(m);

    return;
  }
  //End - For fetching YT Videos

//Start - For fetching Related Movies
  @action
  addSimilarMovies(MovieModel m) async {
    if (m.results!.isEmpty || m.results == null) {
      allSimilar.clear();
    } else {
      for (var element in m.results!) {
        allSimilar.add(element);
      }
      allSimilar.sort(
        (a, b) {
          return b.releaseDate!.compareTo(a.releaseDate!);
        },
      );
    }
  }

  @action
  fetchSimilarMovie(int movieID) async {
    MovieModel m = MovieModel();

    final future = movieServices.fetchSimilarMovie(movieID);

    m = await future;

    addSimilarMovies(m);

    return;
  }

  //End - For fetching Related Movies

  //Start - For fetching Related Movies
  @action
  addMovieCast(MovieCastModel m) async {
    if (m.cast!.isEmpty || m.cast == null) {
      allCast.clear();
    } else {
      for (var element in m.cast!) {
        allCast.add(element);
      }
    }
  }

  @action
  fetchMovieCast(int movieID) async {
    MovieCastModel m = MovieCastModel();

    final future = movieServices.fetchMovieCast(movieID);

    m = await future;

    addMovieCast(m);

    return;
  }

  //End - For fetching Related Movies
}
