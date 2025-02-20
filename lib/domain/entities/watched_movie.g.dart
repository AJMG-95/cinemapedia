// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watched_movie.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetWatchedMovieCollection on Isar {
  IsarCollection<WatchedMovie> get watchedMovies => this.collection();
}

const WatchedMovieSchema = CollectionSchema(
  name: r'WatchedMovie',
  id: 8931501167940743770,
  properties: {
    r'movieId': PropertySchema(
      id: 0,
      name: r'movieId',
      type: IsarType.long,
    ),
    r'watchedDate': PropertySchema(
      id: 1,
      name: r'watchedDate',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _watchedMovieEstimateSize,
  serialize: _watchedMovieSerialize,
  deserialize: _watchedMovieDeserialize,
  deserializeProp: _watchedMovieDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'movieId': IndexSchema(
      id: -1138826636860436442,
      name: r'movieId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'movieId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _watchedMovieGetId,
  getLinks: _watchedMovieGetLinks,
  attach: _watchedMovieAttach,
  version: '3.1.0+1',
);

int _watchedMovieEstimateSize(
  WatchedMovie object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _watchedMovieSerialize(
  WatchedMovie object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.movieId);
  writer.writeDateTime(offsets[1], object.watchedDate);
}

WatchedMovie _watchedMovieDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = WatchedMovie(
    movieId: reader.readLong(offsets[0]),
    watchedDate: reader.readDateTime(offsets[1]),
  );
  object.isarId = id;
  return object;
}

P _watchedMovieDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _watchedMovieGetId(WatchedMovie object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _watchedMovieGetLinks(WatchedMovie object) {
  return [];
}

void _watchedMovieAttach(
    IsarCollection<dynamic> col, Id id, WatchedMovie object) {
  object.isarId = id;
}

extension WatchedMovieQueryWhereSort
    on QueryBuilder<WatchedMovie, WatchedMovie, QWhere> {
  QueryBuilder<WatchedMovie, WatchedMovie, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<WatchedMovie, WatchedMovie, QAfterWhere> anyMovieId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'movieId'),
      );
    });
  }
}

extension WatchedMovieQueryWhere
    on QueryBuilder<WatchedMovie, WatchedMovie, QWhereClause> {
  QueryBuilder<WatchedMovie, WatchedMovie, QAfterWhereClause> isarIdEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<WatchedMovie, WatchedMovie, QAfterWhereClause> isarIdNotEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<WatchedMovie, WatchedMovie, QAfterWhereClause> isarIdGreaterThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<WatchedMovie, WatchedMovie, QAfterWhereClause> isarIdLessThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<WatchedMovie, WatchedMovie, QAfterWhereClause> isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIsarId,
        includeLower: includeLower,
        upper: upperIsarId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WatchedMovie, WatchedMovie, QAfterWhereClause> movieIdEqualTo(
      int movieId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'movieId',
        value: [movieId],
      ));
    });
  }

  QueryBuilder<WatchedMovie, WatchedMovie, QAfterWhereClause> movieIdNotEqualTo(
      int movieId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'movieId',
              lower: [],
              upper: [movieId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'movieId',
              lower: [movieId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'movieId',
              lower: [movieId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'movieId',
              lower: [],
              upper: [movieId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<WatchedMovie, WatchedMovie, QAfterWhereClause>
      movieIdGreaterThan(
    int movieId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'movieId',
        lower: [movieId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<WatchedMovie, WatchedMovie, QAfterWhereClause> movieIdLessThan(
    int movieId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'movieId',
        lower: [],
        upper: [movieId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<WatchedMovie, WatchedMovie, QAfterWhereClause> movieIdBetween(
    int lowerMovieId,
    int upperMovieId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'movieId',
        lower: [lowerMovieId],
        includeLower: includeLower,
        upper: [upperMovieId],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension WatchedMovieQueryFilter
    on QueryBuilder<WatchedMovie, WatchedMovie, QFilterCondition> {
  QueryBuilder<WatchedMovie, WatchedMovie, QAfterFilterCondition> isarIdEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<WatchedMovie, WatchedMovie, QAfterFilterCondition>
      isarIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<WatchedMovie, WatchedMovie, QAfterFilterCondition>
      isarIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<WatchedMovie, WatchedMovie, QAfterFilterCondition> isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WatchedMovie, WatchedMovie, QAfterFilterCondition>
      movieIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'movieId',
        value: value,
      ));
    });
  }

  QueryBuilder<WatchedMovie, WatchedMovie, QAfterFilterCondition>
      movieIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'movieId',
        value: value,
      ));
    });
  }

  QueryBuilder<WatchedMovie, WatchedMovie, QAfterFilterCondition>
      movieIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'movieId',
        value: value,
      ));
    });
  }

  QueryBuilder<WatchedMovie, WatchedMovie, QAfterFilterCondition>
      movieIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'movieId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WatchedMovie, WatchedMovie, QAfterFilterCondition>
      watchedDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'watchedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<WatchedMovie, WatchedMovie, QAfterFilterCondition>
      watchedDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'watchedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<WatchedMovie, WatchedMovie, QAfterFilterCondition>
      watchedDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'watchedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<WatchedMovie, WatchedMovie, QAfterFilterCondition>
      watchedDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'watchedDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension WatchedMovieQueryObject
    on QueryBuilder<WatchedMovie, WatchedMovie, QFilterCondition> {}

extension WatchedMovieQueryLinks
    on QueryBuilder<WatchedMovie, WatchedMovie, QFilterCondition> {}

extension WatchedMovieQuerySortBy
    on QueryBuilder<WatchedMovie, WatchedMovie, QSortBy> {
  QueryBuilder<WatchedMovie, WatchedMovie, QAfterSortBy> sortByMovieId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'movieId', Sort.asc);
    });
  }

  QueryBuilder<WatchedMovie, WatchedMovie, QAfterSortBy> sortByMovieIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'movieId', Sort.desc);
    });
  }

  QueryBuilder<WatchedMovie, WatchedMovie, QAfterSortBy> sortByWatchedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'watchedDate', Sort.asc);
    });
  }

  QueryBuilder<WatchedMovie, WatchedMovie, QAfterSortBy>
      sortByWatchedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'watchedDate', Sort.desc);
    });
  }
}

extension WatchedMovieQuerySortThenBy
    on QueryBuilder<WatchedMovie, WatchedMovie, QSortThenBy> {
  QueryBuilder<WatchedMovie, WatchedMovie, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<WatchedMovie, WatchedMovie, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<WatchedMovie, WatchedMovie, QAfterSortBy> thenByMovieId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'movieId', Sort.asc);
    });
  }

  QueryBuilder<WatchedMovie, WatchedMovie, QAfterSortBy> thenByMovieIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'movieId', Sort.desc);
    });
  }

  QueryBuilder<WatchedMovie, WatchedMovie, QAfterSortBy> thenByWatchedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'watchedDate', Sort.asc);
    });
  }

  QueryBuilder<WatchedMovie, WatchedMovie, QAfterSortBy>
      thenByWatchedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'watchedDate', Sort.desc);
    });
  }
}

extension WatchedMovieQueryWhereDistinct
    on QueryBuilder<WatchedMovie, WatchedMovie, QDistinct> {
  QueryBuilder<WatchedMovie, WatchedMovie, QDistinct> distinctByMovieId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'movieId');
    });
  }

  QueryBuilder<WatchedMovie, WatchedMovie, QDistinct> distinctByWatchedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'watchedDate');
    });
  }
}

extension WatchedMovieQueryProperty
    on QueryBuilder<WatchedMovie, WatchedMovie, QQueryProperty> {
  QueryBuilder<WatchedMovie, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<WatchedMovie, int, QQueryOperations> movieIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'movieId');
    });
  }

  QueryBuilder<WatchedMovie, DateTime, QQueryOperations> watchedDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'watchedDate');
    });
  }
}
