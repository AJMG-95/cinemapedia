// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_movie.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFavoriteMovieCollection on Isar {
  IsarCollection<FavoriteMovie> get favoriteMovies => this.collection();
}

const FavoriteMovieSchema = CollectionSchema(
  name: r'FavoriteMovie',
  id: 4711810972251588754,
  properties: {
    r'movieId': PropertySchema(
      id: 0,
      name: r'movieId',
      type: IsarType.long,
    )
  },
  estimateSize: _favoriteMovieEstimateSize,
  serialize: _favoriteMovieSerialize,
  deserialize: _favoriteMovieDeserialize,
  deserializeProp: _favoriteMovieDeserializeProp,
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
  getId: _favoriteMovieGetId,
  getLinks: _favoriteMovieGetLinks,
  attach: _favoriteMovieAttach,
  version: '3.1.0+1',
);

int _favoriteMovieEstimateSize(
  FavoriteMovie object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _favoriteMovieSerialize(
  FavoriteMovie object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.movieId);
}

FavoriteMovie _favoriteMovieDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FavoriteMovie(
    movieId: reader.readLong(offsets[0]),
  );
  object.isarId = id;
  return object;
}

P _favoriteMovieDeserializeProp<P>(
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

Id _favoriteMovieGetId(FavoriteMovie object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _favoriteMovieGetLinks(FavoriteMovie object) {
  return [];
}

void _favoriteMovieAttach(
    IsarCollection<dynamic> col, Id id, FavoriteMovie object) {
  object.isarId = id;
}

extension FavoriteMovieQueryWhereSort
    on QueryBuilder<FavoriteMovie, FavoriteMovie, QWhere> {
  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterWhere> anyMovieId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'movieId'),
      );
    });
  }
}

extension FavoriteMovieQueryWhere
    on QueryBuilder<FavoriteMovie, FavoriteMovie, QWhereClause> {
  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterWhereClause> isarIdEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterWhereClause>
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

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterWhereClause>
      isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterWhereClause> isarIdLessThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterWhereClause> isarIdBetween(
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

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterWhereClause> movieIdEqualTo(
      int movieId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'movieId',
        value: [movieId],
      ));
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterWhereClause>
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

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterWhereClause>
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

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterWhereClause> movieIdLessThan(
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

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterWhereClause> movieIdBetween(
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

extension FavoriteMovieQueryFilter
    on QueryBuilder<FavoriteMovie, FavoriteMovie, QFilterCondition> {
  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterFilterCondition>
      isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterFilterCondition>
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

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterFilterCondition>
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

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterFilterCondition>
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

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterFilterCondition>
      movieIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'movieId',
        value: value,
      ));
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterFilterCondition>
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

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterFilterCondition>
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

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterFilterCondition>
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

extension FavoriteMovieQueryObject
    on QueryBuilder<FavoriteMovie, FavoriteMovie, QFilterCondition> {}

extension FavoriteMovieQueryLinks
    on QueryBuilder<FavoriteMovie, FavoriteMovie, QFilterCondition> {}

extension FavoriteMovieQuerySortBy
    on QueryBuilder<FavoriteMovie, FavoriteMovie, QSortBy> {
  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterSortBy> sortByMovieId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'movieId', Sort.asc);
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterSortBy> sortByMovieIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'movieId', Sort.desc);
    });
  }
}

extension FavoriteMovieQuerySortThenBy
    on QueryBuilder<FavoriteMovie, FavoriteMovie, QSortThenBy> {
  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterSortBy> thenByMovieId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'movieId', Sort.asc);
    });
  }

  QueryBuilder<FavoriteMovie, FavoriteMovie, QAfterSortBy> thenByMovieIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'movieId', Sort.desc);
    });
  }
}

extension FavoriteMovieQueryWhereDistinct
    on QueryBuilder<FavoriteMovie, FavoriteMovie, QDistinct> {
  QueryBuilder<FavoriteMovie, FavoriteMovie, QDistinct> distinctByMovieId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'movieId');
    });
  }
}

extension FavoriteMovieQueryProperty
    on QueryBuilder<FavoriteMovie, FavoriteMovie, QQueryProperty> {
  QueryBuilder<FavoriteMovie, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<FavoriteMovie, int, QQueryOperations> movieIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'movieId');
    });
  }
}
