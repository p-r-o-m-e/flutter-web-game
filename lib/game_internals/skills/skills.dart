class Skill {
  final String _name;
  final int _damage;
  final SkillType _type;
  const Skill(this._name, this._type, this._damage);
  String get getName => _name;
  int get getDamageNumber => _damage;
  SkillType get getDamageType => _type;
}

enum SkillType { physical, special }
