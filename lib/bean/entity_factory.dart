///
/// entity_factory
///
/// created by DZDcyj at 2021/11/28
///
import 'bean.dart';

typedef EntityGenerator<T> = T Function(dynamic json);

/// 实体生成器
class _Generator<T> {
  _Generator(this.generator, {this.name});

  final EntityGenerator<T> generator;
  final String name;

  String get keyName => name ?? T.toString();
}

/// 实体工厂
class EntityFactory {
  /// 创建实体对象
  static generate<T>(dynamic json) {
    EntityGenerator<T> generator = generators[T.toString()];
    return generator != null ? generator(json) : null;
  }

  /// 实体构建
  static final generators = Map.fromIterable(
    [
      _Generator<MapEntity>(
        (json) => MapEntity.fromJson(json),
      ),
      _Generator<HttpResponseEntity>(
        (json) => HttpResponseEntity.fromJson(json),
      ),
    ],
    key: (g) => g.keyName,
    value: (g) => g.generator,
  );
}
