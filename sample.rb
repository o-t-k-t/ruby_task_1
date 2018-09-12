class Player
  def hand
    # コンソールを入力待ち状態にし、プレイヤーがコンソールから打ち込んだ値を出力する処理のメソッドの処理をこの中に作成する
    # ユーザ操作受付
    msg = <<~TEXT
      数字を入力してください。
      0: グー
      1: チョキ
      2: パー
    TEXT
    puts(msg)        
    input = gets.to_i

    # 無効値なら再受付
    unless input.between?(0, 2)
      puts '0〜2の数字を入力してください。'
      hand  
    end

    # ユーザの出した手が有効値なら確定
    input
  end
end

class Enemy
  def hand
    # グー、チョキ、パーの値をランダムに出力するメソッドの処理をこの中に作成する  
    rand(0..2)
  end
end
  
class Janken
  def pon(player_hand, enemy_hand)
    # プレイヤーが打ち込んだ値と、Enemyがランダムに出した値でじゃんけんをさせ、その結果をコンソール上に出力するメソッドをこの中に作成する
    # その際、あいこもしくはグー、チョキ、パー以外の値入力時には、もう一度ジャンケンをする
    # 相手がグー、チョキ、パーのうち、何を出したのかも表示させる

    hand_names = %w(グー チョキ パー)

    # お互いの手を表示
    print("相手の手は#{hand_names[enemy_hand]}です。")

    # ヒント1の勝敗組み合わせ表に基づく判定
    result = (3 + player_hand - enemy_hand) % 3
    case result
    when 0
      puts 'あいこです。'

      # 再帰によるじゃんけん継続
      player = Player.new
      enemy = Enemy.new
      pon(player.hand, enemy.hand) 
    when 1
      puts 'あなたの負けです。'  
    when 2
      puts 'あなたの勝ちです。'  
    else 
      raise 'illegal hand code'
    end
  end
end
  
# Playerクラスのインスタンスを作成し、変数playerに代入
player = Player.new
# 先頭大文字のPlayerはPlayerクラス(プログラムの設計図)を示す。変数playerはインスタンス(クラスを元に作られたプログラムの実行実体単位)。

enemy = Enemy.new 
janken = Janken.new

# 下記の記述で、ジャンケンメソッドが起動される
janken.pon(player.hand, enemy.hand)
