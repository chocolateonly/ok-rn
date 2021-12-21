// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AppStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppStore on AppStoreBase, Store {
  final _$selectedLanguageAtom = Atom(name: 'AppStoreBase.selectedLanguage');

  @override
  LanguageDataModel? get selectedLanguage {
    _$selectedLanguageAtom.reportRead();
    return super.selectedLanguage;
  }

  @override
  set selectedLanguage(LanguageDataModel? value) {
    _$selectedLanguageAtom.reportWrite(value, super.selectedLanguage, () {
      super.selectedLanguage = value;
    });
  }

  final _$mSelectedGraphColorAtom =
      Atom(name: 'AppStoreBase.mSelectedGraphColor');

  @override
  Color get mSelectedGraphColor {
    _$mSelectedGraphColorAtom.reportRead();
    return super.mSelectedGraphColor;
  }

  @override
  set mSelectedGraphColor(Color value) {
    _$mSelectedGraphColorAtom.reportWrite(value, super.mSelectedGraphColor, () {
      super.mSelectedGraphColor = value;
    });
  }

  final _$mSelectedCurrencyAtom = Atom(name: 'AppStoreBase.mSelectedCurrency');

  @override
  CurrencyModel? get mSelectedCurrency {
    _$mSelectedCurrencyAtom.reportRead();
    return super.mSelectedCurrency;
  }

  @override
  set mSelectedCurrency(CurrencyModel? value) {
    _$mSelectedCurrencyAtom.reportWrite(value, super.mSelectedCurrency, () {
      super.mSelectedCurrency = value;
    });
  }

  final _$mIsLoadingAtom = Atom(name: 'AppStoreBase.mIsLoading');

  @override
  bool? get mIsLoading {
    _$mIsLoadingAtom.reportRead();
    return super.mIsLoading;
  }

  @override
  set mIsLoading(bool? value) {
    _$mIsLoadingAtom.reportWrite(value, super.mIsLoading, () {
      super.mIsLoading = value;
    });
  }

  final _$setSelectedGraphColorAsyncAction =
      AsyncAction('AppStoreBase.setSelectedGraphColor');

  @override
  Future<dynamic> setSelectedGraphColor(Color aColor) {
    return _$setSelectedGraphColorAsyncAction
        .run(() => super.setSelectedGraphColor(aColor));
  }

  final _$setLoadingAsyncAction = AsyncAction('AppStoreBase.setLoading');

  @override
  Future<dynamic> setLoading(bool aIsLoading) {
    return _$setLoadingAsyncAction.run(() => super.setLoading(aIsLoading));
  }

  final _$setSelectedCurrencyAsyncAction =
      AsyncAction('AppStoreBase.setSelectedCurrency');

  @override
  Future<CurrencyModel> setSelectedCurrency(CurrencyModel aSelectedCurrency) {
    return _$setSelectedCurrencyAsyncAction
        .run(() => super.setSelectedCurrency(aSelectedCurrency));
  }

  final _$AppStoreBaseActionController = ActionController(name: 'AppStoreBase');

  @override
  Future<void>? setLanguage(String? aCode) {
    final _$actionInfo = _$AppStoreBaseActionController.startAction(
        name: 'AppStoreBase.setLanguage');
    try {
      return super.setLanguage(aCode);
    } finally {
      _$AppStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedLanguage: ${selectedLanguage},
mSelectedGraphColor: ${mSelectedGraphColor},
mSelectedCurrency: ${mSelectedCurrency},
mIsLoading: ${mIsLoading}
    ''';
  }
}
