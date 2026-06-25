// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calculation_record.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCalculationRecordCollection on Isar {
  IsarCollection<CalculationRecord> get calculationRecords => this.collection();
}

const CalculationRecordSchema = CollectionSchema(
  name: r'CalculationRecord',
  id: -3820708926729864158,
  properties: {
    r'expression': PropertySchema(
      id: 0,
      name: r'expression',
      type: IsarType.string,
    ),
    r'result': PropertySchema(
      id: 1,
      name: r'result',
      type: IsarType.string,
    ),
    r'timestamp': PropertySchema(
      id: 2,
      name: r'timestamp',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _calculationRecordEstimateSize,
  serialize: _calculationRecordSerialize,
  deserialize: _calculationRecordDeserialize,
  deserializeProp: _calculationRecordDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _calculationRecordGetId,
  getLinks: _calculationRecordGetLinks,
  attach: _calculationRecordAttach,
  version: '3.1.0+1',
);

int _calculationRecordEstimateSize(
  CalculationRecord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.expression.length * 3;
  bytesCount += 3 + object.result.length * 3;
  return bytesCount;
}

void _calculationRecordSerialize(
  CalculationRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.expression);
  writer.writeString(offsets[1], object.result);
  writer.writeDateTime(offsets[2], object.timestamp);
}

CalculationRecord _calculationRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CalculationRecord();
  object.expression = reader.readString(offsets[0]);
  object.id = id;
  object.result = reader.readString(offsets[1]);
  object.timestamp = reader.readDateTime(offsets[2]);
  return object;
}

P _calculationRecordDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _calculationRecordGetId(CalculationRecord object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _calculationRecordGetLinks(
    CalculationRecord object) {
  return [];
}

void _calculationRecordAttach(
    IsarCollection<dynamic> col, Id id, CalculationRecord object) {
  object.id = id;
}

extension CalculationRecordQueryWhereSort
    on QueryBuilder<CalculationRecord, CalculationRecord, QWhere> {
  QueryBuilder<CalculationRecord, CalculationRecord, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CalculationRecordQueryWhere
    on QueryBuilder<CalculationRecord, CalculationRecord, QWhereClause> {
  QueryBuilder<CalculationRecord, CalculationRecord, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CalculationRecord, CalculationRecord, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<CalculationRecord, CalculationRecord, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CalculationRecord, CalculationRecord, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CalculationRecord, CalculationRecord, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CalculationRecordQueryFilter
    on QueryBuilder<CalculationRecord, CalculationRecord, QFilterCondition> {
  QueryBuilder<CalculationRecord, CalculationRecord, QAfterFilterCondition>
      expressionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expression',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalculationRecord, CalculationRecord, QAfterFilterCondition>
      expressionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'expression',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalculationRecord, CalculationRecord, QAfterFilterCondition>
      expressionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'expression',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalculationRecord, CalculationRecord, QAfterFilterCondition>
      expressionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'expression',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalculationRecord, CalculationRecord, QAfterFilterCondition>
      expressionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'expression',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalculationRecord, CalculationRecord, QAfterFilterCondition>
      expressionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'expression',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalculationRecord, CalculationRecord, QAfterFilterCondition>
      expressionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'expression',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalculationRecord, CalculationRecord, QAfterFilterCondition>
      expressionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'expression',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalculationRecord, CalculationRecord, QAfterFilterCondition>
      expressionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expression',
        value: '',
      ));
    });
  }

  QueryBuilder<CalculationRecord, CalculationRecord, QAfterFilterCondition>
      expressionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'expression',
        value: '',
      ));
    });
  }

  QueryBuilder<CalculationRecord, CalculationRecord, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CalculationRecord, CalculationRecord, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CalculationRecord, CalculationRecord, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CalculationRecord, CalculationRecord, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CalculationRecord, CalculationRecord, QAfterFilterCondition>
      resultEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'result',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalculationRecord, CalculationRecord, QAfterFilterCondition>
      resultGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'result',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalculationRecord, CalculationRecord, QAfterFilterCondition>
      resultLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'result',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalculationRecord, CalculationRecord, QAfterFilterCondition>
      resultBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'result',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalculationRecord, CalculationRecord, QAfterFilterCondition>
      resultStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'result',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalculationRecord, CalculationRecord, QAfterFilterCondition>
      resultEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'result',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalculationRecord, CalculationRecord, QAfterFilterCondition>
      resultContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'result',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalculationRecord, CalculationRecord, QAfterFilterCondition>
      resultMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'result',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CalculationRecord, CalculationRecord, QAfterFilterCondition>
      resultIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'result',
        value: '',
      ));
    });
  }

  QueryBuilder<CalculationRecord, CalculationRecord, QAfterFilterCondition>
      resultIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'result',
        value: '',
      ));
    });
  }

  QueryBuilder<CalculationRecord, CalculationRecord, QAfterFilterCondition>
      timestampEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<CalculationRecord, CalculationRecord, QAfterFilterCondition>
      timestampGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<CalculationRecord, CalculationRecord, QAfterFilterCondition>
      timestampLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<CalculationRecord, CalculationRecord, QAfterFilterCondition>
      timestampBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timestamp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CalculationRecordQueryObject
    on QueryBuilder<CalculationRecord, CalculationRecord, QFilterCondition> {}

extension CalculationRecordQueryLinks
    on QueryBuilder<CalculationRecord, CalculationRecord, QFilterCondition> {}

extension CalculationRecordQuerySortBy
    on QueryBuilder<CalculationRecord, CalculationRecord, QSortBy> {
  QueryBuilder<CalculationRecord, CalculationRecord, QAfterSortBy>
      sortByExpression() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expression', Sort.asc);
    });
  }

  QueryBuilder<CalculationRecord, CalculationRecord, QAfterSortBy>
      sortByExpressionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expression', Sort.desc);
    });
  }

  QueryBuilder<CalculationRecord, CalculationRecord, QAfterSortBy>
      sortByResult() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'result', Sort.asc);
    });
  }

  QueryBuilder<CalculationRecord, CalculationRecord, QAfterSortBy>
      sortByResultDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'result', Sort.desc);
    });
  }

  QueryBuilder<CalculationRecord, CalculationRecord, QAfterSortBy>
      sortByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<CalculationRecord, CalculationRecord, QAfterSortBy>
      sortByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }
}

extension CalculationRecordQuerySortThenBy
    on QueryBuilder<CalculationRecord, CalculationRecord, QSortThenBy> {
  QueryBuilder<CalculationRecord, CalculationRecord, QAfterSortBy>
      thenByExpression() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expression', Sort.asc);
    });
  }

  QueryBuilder<CalculationRecord, CalculationRecord, QAfterSortBy>
      thenByExpressionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expression', Sort.desc);
    });
  }

  QueryBuilder<CalculationRecord, CalculationRecord, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CalculationRecord, CalculationRecord, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CalculationRecord, CalculationRecord, QAfterSortBy>
      thenByResult() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'result', Sort.asc);
    });
  }

  QueryBuilder<CalculationRecord, CalculationRecord, QAfterSortBy>
      thenByResultDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'result', Sort.desc);
    });
  }

  QueryBuilder<CalculationRecord, CalculationRecord, QAfterSortBy>
      thenByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<CalculationRecord, CalculationRecord, QAfterSortBy>
      thenByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }
}

extension CalculationRecordQueryWhereDistinct
    on QueryBuilder<CalculationRecord, CalculationRecord, QDistinct> {
  QueryBuilder<CalculationRecord, CalculationRecord, QDistinct>
      distinctByExpression({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'expression', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CalculationRecord, CalculationRecord, QDistinct>
      distinctByResult({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'result', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CalculationRecord, CalculationRecord, QDistinct>
      distinctByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timestamp');
    });
  }
}

extension CalculationRecordQueryProperty
    on QueryBuilder<CalculationRecord, CalculationRecord, QQueryProperty> {
  QueryBuilder<CalculationRecord, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CalculationRecord, String, QQueryOperations>
      expressionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'expression');
    });
  }

  QueryBuilder<CalculationRecord, String, QQueryOperations> resultProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'result');
    });
  }

  QueryBuilder<CalculationRecord, DateTime, QQueryOperations>
      timestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timestamp');
    });
  }
}
