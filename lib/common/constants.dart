/* 오류 메시지 */
const String errorNone = '';
const String errorNetwork = '네트워크 통신에 실패했습니다';
const String errorNotFoundImage = '이미지를 불러올 수 없습니다';

/* 네트워크 URL */
const movieMainUrl = 'https://api.themoviedb.org/3/movie/upcoming?api_key=a64533e7ece6c72731da47c9c8bc691f&language=ko-KR&page=';
const movieDetailUrlPrefix = 'https://api.themoviedb.org/3/movie/';
const movieDetailUrlSuffix = '?api_key=a64533e7ece6c72731da47c9c8bc691f&language=ko-KR';

/* 이미지 URL */
const String imagePathSmall = 'https://image.tmdb.org/t/p/w200';
const String imagePathLarge = 'https://image.tmdb.org/t/p/w500';

/* 영화 상세 매핑 정보 */
const statusMap = {
  'Released' : '상영중',
  'Post Production' : '포스트 프로덕션',
  'In Production' : '제작중'
};

/* 라우터 쿼리 파라미터 정보 (prefix : qp) */
const qpMovieId = 'movieId';