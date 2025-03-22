class AllCountriesResponse {
  final Name? name;
  final Map<String, Currency>? currencies;

  AllCountriesResponse({this.name, this.currencies});

  factory AllCountriesResponse.fromJson(Map<String, dynamic> json) {
    return AllCountriesResponse(
      name: json['name'] != null ? Name.fromJson(json['name']) : null,
      currencies: json['currencies'] != null
          ? (json['currencies'] as Map<String, dynamic>).map(
              (key, value) => MapEntry(key, Currency.fromJson(value)),
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name?.toJson(),
      'currencies': currencies?.map(
        (key, value) => MapEntry(key, value.toJson()),
      ),
    };
  }
}

class Name {
  final String? common;
  final String? official;
  final Map<String, NativeName>? nativeName;

  Name({this.common, this.official, this.nativeName});

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      common: json['common'],
      official: json['official'],
      nativeName: json['nativeName'] != null
          ? (json['nativeName'] as Map<String, dynamic>).map(
              (key, value) => MapEntry(key, NativeName.fromJson(value)),
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'common': common,
      'official': official,
      'nativeName': nativeName?.map(
        (key, value) => MapEntry(key, value.toJson()),
      ),
    };
  }
}

class NativeName {
  final String? official;
  final String? common;

  NativeName({this.official, this.common});

  factory NativeName.fromJson(Map<String, dynamic> json) {
    return NativeName(
      official: json['official'],
      common: json['common'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'official': official,
      'common': common,
    };
  }
}

class Currency {
  final String? name;
  final String? symbol;

  Currency({this.name, this.symbol});

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      name: json['name'],
      symbol: json['symbol'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'symbol': symbol,
    };
  }
}
