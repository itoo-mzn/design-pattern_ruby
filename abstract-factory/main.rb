## 設定
# - 動物（アヒル、カエル）
#   - 食事(eat)メソッドを持っている。
# - 植物（藻、スイレン）
#   - 成長(grow)メソッドを持っている。
# - 池
#   - 池の環境(動物と植物の組み合わせ)は、次の2種類のみが許されている。
#     - アヒル と スイレン
#     - カエル と 藻

# この池の環境の制約を守る (=矛盾のないオブジェクトの組み合わせを作る) のが「Abstract Factoryパターン」

# ----------------------------------------------------------
# 実体「Product」
# アヒル
class Duck
  def initialize(name)
    @name = name
  end

  def eat
    puts "アヒル #{@name}は食事中"
  end
end

# カエル
class Frog
  def initialize(name)
    @name = name
  end

  def eat
    puts "カエル #{@name}は食事中"
  end
end

# 藻
class Algae
  def initialize(name)
    @name = name
  end

  def grow
    puts "藻 #{@name}は成長中"
  end
end

# スイレン
class WaterLily
  def initialize(name)
    @name = name
  end

  def grow
    puts "スイレン #{@name}は成長中"
  end
end

# ----------------------------------------------------------
# 池の生態系を作る「AbstractFactory」
class OrganismFactory
  def initialize(number_animals:, number_plants:)
    @animals = []
    number_animals.times do |i|
      animal = new_animal("動物 #{i}")
      @animals << animal
    end

    @plants = []
    number_plants.times do |i|
      plant = new_plant("植物 #{i}")
      @plants << plant
    end
  end

  def get_animals
    @animals
  end
  
  def get_plants
    @plants
  end
end

# ----------------------------------------------------------
# 正しい組み合わせのオブジェクトを生成する「ConcreteFactory」
class FrogAndAlgaeFactory < OrganismFactory
  private

  def new_animal(name)
    Frog.new(name)
  end
  
  def new_plant(name)
    Algae.new(name)
  end
end

class DuckAndWaterLilyFactory < OrganismFactory
  private

  def new_animal(name)
    Duck.new(name)
  end
  
  def new_plant(name)
    WaterLily.new(name)
  end
end

# ----------------------------------------------------------
# main
factory = FrogAndAlgaeFactory.new(number_animals: 4, number_plants: 1)
animals = factory.get_animals
# p animals
animals.each { |animal| animal.eat}
plants = factory.get_plants
# p plants
plants.each { |plant| plant.grow}

# カエル 動物 0は食事中
# カエル 動物 1は食事中
# カエル 動物 2は食事中
# カエル 動物 3は食事中
# 藻 植物 0は成長中

# 上と同じことをしているのに、別のFactoryを使っているので、上とは別の組み合わせのオブジェクトが作られる。
factory = DuckAndWaterLilyFactory.new(number_animals: 3, number_plants: 2)
animals = factory.get_animals
# p animals
animals.each { |animal| animal.eat}
plants = factory.get_plants
# p plants
plants.each { |plant| plant.grow}

# アヒル 動物 0は食事中
# アヒル 動物 1は食事中
# アヒル 動物 2は食事中
# スイレン 植物 0は成長中
# スイレン 植物 1は成長中