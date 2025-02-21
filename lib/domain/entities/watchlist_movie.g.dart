// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watchlist_movie.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetWatchlistMovieCollection on Isar {
  IsarCollection<WatchlistMovie> get watchlistMovies => this.collection();
}

const WatchlistMovieSchema = CollectionSchema(
  name: r'WatchlistMovie',
  id: -298808979612091411,
  properties: {
    r'movieId': PropertySchema(
      id: 0,
      name: r'movieId',
      type: IsarType.long,
    )
  },
  estimateSize: _watchlistMovieEstimateSize,
  serialize: _watchlistMovieSerialize,
  deserialize: _watchlistMovieDeserialize,
  deserializeProp: _watchlistMovieDeserializeProp,
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
  getId: _watchlistMovieGetId,
  getLinks: _watchlistMovieGetLinks,
  attach: _watchlistMovieAttach,
  version: '3.1.0+1',
);

int _watchlistMovieEstimateSize(
  WatchlistMovie object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _watchlistMovieSerialize(
  WatchlistMovie object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.movieId);
}

WatchlistMovie _watchlistMovieDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = WatchlistMovie(
    movieId: reader.readLong(offsets[0]),
  );
  object.isarId = id;
  return object;
}

P _watchlistMovieDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _watchlistMovieGetId(WatchlistMovie object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _watchlistMovieGetLinks(WatchlistMovie object) {
  return [];
}

void _watchlistMovieAttach(
    IsarCollection<dynamic> col, Id id, WatchlistMovie object) {
  object.isarId = id;
}

extension WatchlistMovieQueryWhereSort
    on QueryBuilder<WatchlistMovie, WatchlistMovie, QWhere> {
  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterWhere> anyMovieId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'movieId'),
      );
    });
  }
}

extension WatchlistMovieQueryWhere
    on QueryBuilder<WatchlistMovie, WatchlistMovie, QWhereClause> {
  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterWhereClause> isarIdEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterWhereClause>
      isarIdNotEqualTo(Id isarId) {
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

  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterWhereClause>
      isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterWhereClause>
      isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterWhereClause> isarIdBetween(
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

  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterWhereClause>
      movieIdEqualTo(int movieId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'movieId',
        value: [movieId],
      ));
    });
  }

  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterWhereClause>
      movieIdNotEqualTo(int movieId) {
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

  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterWhereClause>
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

  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterWhereClause>
      movieIdLessThan(
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

  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterWhereClause>
      movieIdBetween(
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

extension WatchlistMovieQueryFilter
    on QueryBuilder<WatchlistMovie, WatchlistMovie, QFilterCondition> {
  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterFilterCondition>
      isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterFilterCondition>
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

  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterFilterCondition>
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

  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterFilterCondition>
      isarIdBetween(
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

  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterFilterCondition>
      movieIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'movieId',
        value: value,
      ));
    });
  }

  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterFilterCondition>
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

  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterFilterCondition>
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

  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterFilterCondition>
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
}

extension WatchlistMovieQueryObject
    on QueryBuilder<WatchlistMovie, WatchlistMovie, QFilterCondition> {}

extension WatchlistMovieQueryLinks
    on QueryBuilder<WatchlistMovie, WatchlistMovie, QFilterCondition> {}

extension WatchlistMovieQuerySortBy
    on QueryBuilder<WatchlistMovie, WatchlistMovie, QSortBy> {
  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterSortBy> sortByMovieId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'movieId', Sort.asc);
    });
  }

  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterSortBy>
      sortByMovieIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'movieId', Sort.desc);
    });
  }
}

extension WatchlistMovieQuerySortThenBy
    on QueryBuilder<WatchlistMovie, WatchlistMovie, QSortThenBy> {
  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterSortBy>
      thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterSortBy> thenByMovieId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'movieId', Sort.asc);
    });
  }

  QueryBuilder<WatchlistMovie, WatchlistMovie, QAfterSortBy>
      thenByMovieIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'movieId', Sort.desc);
    });
  }
}

extension WatchlistMovieQueryWhereDistinct
    on QueryBuilder<WatchlistMovie, WatchlistMovie, QDistinct> {
  QueryBuilder<WatchlistMovie, WatchlistMovie, QDistinct> distinctByMovieId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'movieId');
    });
  }
}

extension WatchlistMovieQueryProperty
    on QueryBuilder<WatchlistMovie, WatchlistMovie, QQueryProperty> {
  QueryBuilder<WatchlistMovie, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<WatchlistMovie, int, QQueryOperations> movieIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'movieId');
    });
  }
}
