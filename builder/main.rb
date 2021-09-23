# 使われる場面
# オブジェクトの生成に大量のコードが必要
# オブジェクトを作り出すのが難しい
# オブジェクト生成時に必要なチェックを行いたい

# 構成
# 作成過程を決定する「Director」と作業インタフェースをもつ「Builder」を組み合わせることで、
# 柔軟にオブジェクトを生成をできるデザインパターン。

# 構成要素(3つ)
# ディレクター(Director)：Builderで提供されているインタフェースのみを使用して処理を行う
# ビルダ(Builder)：各メソッドのインタフェースを定める
# 具体ビルダ(ConcreteBuilder)：Builderが定めたインタフェースの実装

# ----------------------------------------------------------

# 砂糖水 (ConcreteBuilder：ビルダーの実装部分)
class SugarWater
  attr_accessor :water, :sugar

  def initialize(water, sugar)
    @water = water
    @sugar = sugar
  end

  def add_material(sugar_amount)
    @sugar += sugar_amount
  end
end

# 塩水 (ConcreteBuilder：ビルダーの実装部分)
class SaltWater
  attr_accessor :water, :salt

  def initialize(water, salt)
    @water = water
    @salt = salt
  end

  def add_material(salt_amount)
    @salt += salt_amount
  end
end

# 各メソッドのインターフェイス（ビルダ）
class WaterWithMaterialBuilder
  def initialize(class_name)
    @water_with_material = class_name.new(0, 0)
  end

  # 水を加える
  def add_water(water_amount)
    @water_with_material.water += water_amount
  end

  # 砂糖or塩を加える
  # 具象ビルダごとで異なる処理は、具象ビルダで定義
  def add_material(material_amount)
    @water_with_material.add_material(material_amount)
  end

  # 砂糖水or塩水の状態を返す
  def result
    @water_with_material
  end
end

# 砂糖水の作成工程を決める
# ※ Builderで提供されているインタフェースのみを使用すること
class Director
  def initialize(builder)
    @builder = builder
  end

  def cook
    @builder.add_water(150)
    @builder.add_material(90)
    @builder.add_water(300)
    @builder.add_material(35)
  end
end

# ----------------------------------------------------------

# 砂糖水を作る
builder = WaterWithMaterialBuilder.new(SugarWater)
director = Director.new(builder)
director.cook
p builder.result
# <SugarWater:0x00007fe1cc064400 @water=450, @sugar=125>

# 塩水を作る
builder = WaterWithMaterialBuilder.new(SaltWater)
director = Director.new(builder)
director.cook
p builder.result
# <SaltWater:0x00007fe1cc0641f8 @water=450, @salt=125>
