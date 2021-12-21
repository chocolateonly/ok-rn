// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ChartStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChartStore on ChartStoreBase, Store {
  final _$mSelectedChartMarketTypeAtom =
      Atom(name: 'ChartStoreBase.mSelectedChartMarketType');

  @override
  ChartMarketType get mSelectedChartMarketType {
    _$mSelectedChartMarketTypeAtom.reportRead();
    return super.mSelectedChartMarketType;
  }

  @override
  set mSelectedChartMarketType(ChartMarketType value) {
    _$mSelectedChartMarketTypeAtom
        .reportWrite(value, super.mSelectedChartMarketType, () {
      super.mSelectedChartMarketType = value;
    });
  }

  final _$mRangeDifferenceAtom = Atom(name: 'ChartStoreBase.mRangeDifference');

  @override
  int get mRangeDifference {
    _$mRangeDifferenceAtom.reportRead();
    return super.mRangeDifference;
  }

  @override
  set mRangeDifference(int value) {
    _$mRangeDifferenceAtom.reportWrite(value, super.mRangeDifference, () {
      super.mRangeDifference = value;
    });
  }

  final _$mExchangeRangeDifferenceAtom =
      Atom(name: 'ChartStoreBase.mExchangeRangeDifference');

  @override
  int get mExchangeRangeDifference {
    _$mExchangeRangeDifferenceAtom.reportRead();
    return super.mExchangeRangeDifference;
  }

  @override
  set mExchangeRangeDifference(int value) {
    _$mExchangeRangeDifferenceAtom
        .reportWrite(value, super.mExchangeRangeDifference, () {
      super.mExchangeRangeDifference = value;
    });
  }

  final _$mFromDateAtom = Atom(name: 'ChartStoreBase.mFromDate');

  @override
  DateTime? get mFromDate {
    _$mFromDateAtom.reportRead();
    return super.mFromDate;
  }

  @override
  set mFromDate(DateTime? value) {
    _$mFromDateAtom.reportWrite(value, super.mFromDate, () {
      super.mFromDate = value;
    });
  }

  final _$mToDateAtom = Atom(name: 'ChartStoreBase.mToDate');

  @override
  DateTime? get mToDate {
    _$mToDateAtom.reportRead();
    return super.mToDate;
  }

  @override
  set mToDate(DateTime? value) {
    _$mToDateAtom.reportWrite(value, super.mToDate, () {
      super.mToDate = value;
    });
  }

  final _$mIsDateSelectedAtom = Atom(name: 'ChartStoreBase.mIsDateSelected');

  @override
  bool? get mIsDateSelected {
    _$mIsDateSelectedAtom.reportRead();
    return super.mIsDateSelected;
  }

  @override
  set mIsDateSelected(bool? value) {
    _$mIsDateSelectedAtom.reportWrite(value, super.mIsDateSelected, () {
      super.mIsDateSelected = value;
    });
  }

  final _$setSelectedChartMarketTypeAsyncAction =
      AsyncAction('ChartStoreBase.setSelectedChartMarketType');

  @override
  Future<dynamic> setSelectedChartMarketType(ChartMarketType aChartMarketType) {
    return _$setSelectedChartMarketTypeAsyncAction
        .run(() => super.setSelectedChartMarketType(aChartMarketType));
  }

  final _$setFromDateAsyncAction = AsyncAction('ChartStoreBase.setFromDate');

  @override
  Future<dynamic> setFromDate(DateTime fromDate) {
    return _$setFromDateAsyncAction.run(() => super.setFromDate(fromDate));
  }

  final _$setToDateAsyncAction = AsyncAction('ChartStoreBase.setToDate');

  @override
  Future<dynamic> setToDate(DateTime toDate) {
    return _$setToDateAsyncAction.run(() => super.setToDate(toDate));
  }

  final _$setIsDateSelectedAsyncAction =
      AsyncAction('ChartStoreBase.setIsDateSelected');

  @override
  Future<dynamic> setIsDateSelected(bool toDateSelected) {
    return _$setIsDateSelectedAsyncAction
        .run(() => super.setIsDateSelected(toDateSelected));
  }

  final _$setRangeDifferenceAsyncAction =
      AsyncAction('ChartStoreBase.setRangeDifference');

  @override
  Future<dynamic> setRangeDifference(int aRangeDifference) {
    return _$setRangeDifferenceAsyncAction
        .run(() => super.setRangeDifference(aRangeDifference));
  }

  final _$setExchangeRangeDifferenceAsyncAction =
      AsyncAction('ChartStoreBase.setExchangeRangeDifference');

  @override
  Future<dynamic> setExchangeRangeDifference(int aRangeDifference) {
    return _$setExchangeRangeDifferenceAsyncAction
        .run(() => super.setExchangeRangeDifference(aRangeDifference));
  }

  @override
  String toString() {
    return '''
mSelectedChartMarketType: ${mSelectedChartMarketType},
mRangeDifference: ${mRangeDifference},
mExchangeRangeDifference: ${mExchangeRangeDifference},
mFromDate: ${mFromDate},
mToDate: ${mToDate},
mIsDateSelected: ${mIsDateSelected}
    ''';
  }
}
