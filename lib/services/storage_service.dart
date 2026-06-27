import 'dart:convert';

/// Interface for local key-value storage (uses SharedPreferences in production).
/// Extend this with a concrete SharedPreferences-based implementation.
abstract class StorageService {
  Future<bool> setString(String key, String value);
  Future<String?> getString(String key);
  Future<bool> setBool(String key, bool value);
  Future<bool?> getBool(String key);
  Future<bool> setInt(String key, int value);
  Future<int?> getInt(String key);
  Future<bool> remove(String key);
  Future<bool> clear();
}

/// In‑memory implementation for testing / demo purposes.
class InMemoryStorage implements StorageService {
  final Map<String, String> _store = {};

  @override
  Future<bool> setString(String key, String value) async {
    _store[key] = value;
    return true;
  }

  @override
  Future<String?> getString(String key) async => _store[key];

  @override
  Future<bool> setBool(String key, bool value) async {
    _store[key] = value.toString();
    return true;
  }

  @override
  Future<bool?> getBool(String key) async {
    final v = _store[key];
    if (v == null) return null;
    return v == 'true';
  }

  @override
  Future<bool> setInt(String key, int value) async {
    _store[key] = value.toString();
    return true;
  }

  @override
  Future<int?> getInt(String key) async {
    final v = _store[key];
    if (v == null) return null;
    return int.tryParse(v);
  }

  @override
  Future<bool> remove(String key) async {
    _store.remove(key);
    return true;
  }

  @override
  Future<bool> clear() async {
    _store.clear();
    return true;
  }
}

/// Helper extensions for working with JSON objects in storage.
extension StorageHelper on StorageService {
  Future<bool> setJson(String key, Map<String, dynamic> value) =>
      setString(key, jsonEncode(value));

  Future<Map<String, dynamic>?> getJson(String key) async {
    final s = await getString(key);
    if (s == null) return null;
    return jsonDecode(s) as Map<String, dynamic>;
  }

  Future<bool> setList(String key, List<dynamic> value) =>
      setString(key, jsonEncode(value));

  Future<List<dynamic>?> getList(String key) async {
    final s = await getString(key);
    if (s == null) return null;
    return jsonDecode(s) as List<dynamic>;
  }
}