class Role {
  final String name;
  final int count;

  factory Role.fromString(String name) {
    switch (name) {
      case "parent":
        return Role.parent(name);
      case "judge":
        return Role.judge(name);
      case "coach":
        return Role.coach(name);
      case "owner":
        return Role.owner(name);
      default:
        return Role.none();
    }
  }

  Role.parent(this.name, {this.count = 1});
  Role.judge(this.name, {this.count = 2});
  Role.coach(this.name, {this.count = 3});
  Role.owner(this.name, {this.count = 5});
  Role.none({this.name = "invalid", this.count = 0});
}
