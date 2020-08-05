class Mastermind
  attr_reader :riddle, :colors, :hint, :counter_guess

  @@colors = ["yellow", "red", "blue", "green"];
  @@riddle = [];
  @@hint = [];
  @@counter_guess = 0;

  def self.gameStart
    self.initRiddle;
  end

  def self.initRiddle
    if @@riddle.length === 0
      @@riddle = [@@colors[rand(4)],@@colors[rand(4)],@@colors[rand(4)],@@colors[rand(4)]];
    end
    self.getPlayerInput;
  end
 
  def self.getPlayerInput
    @@playerInput = [];
    text = {
      1 => 'First color',
      2 => 'Second color',
      3 => 'Third color',
      4 => 'Fourth color'
    }
    puts 'Enter your guess 0-yellow 1-red 2-blue 3-green.';
    text.each do |key, value|
      puts value;
      input = gets.chomp.to_i;
      while (input < 0) || (input > 3)
        puts 'Your input is out of range. Please enter again.'
        input = gets.chomp.to_i;
      end
      @@playerInput.push(@@colors[input]);
    end
    @@counter_guess += 1;
    self.compareInputWithRiddle;
  end

  def self.compareInputWithRiddle
    copyOfRiddle = [];
    copyOfPlayerInput = [];
    @@riddle.each { |color|
      copyOfRiddle.push(color);
    }
    @@playerInput.each { |input|
      copyOfPlayerInput.push(input);
   }
    counterSameAll = 0;
    counterWrongPos = 0;
    copyOfRiddle.each_with_index { |color, i|
      if color === copyOfPlayerInput[i]
        counterSameAll += 1;
        copyOfRiddle[i] = '';
        copyOfPlayerInput[i] = '0';
      end
    }
   i = 0;
   x = 0;
   while i < copyOfPlayerInput.length
    while x < copyOfRiddle.length
      if copyOfPlayerInput[i] === copyOfRiddle[x]
        copyOfRiddle[x] = '';
        copyOfPlayerInput[i] = '0';
        counterWrongPos += 1;
        break
      end
      x += 1;
    end
    i += 1;
    x = 0;
   end
   if self.checkWin(counterSameAll) || self.checkRounds(@@counter_guess)
    self.playAgain
    return
   end
   self.giveHints(counterSameAll, counterWrongPos);
  end

  def self.giveHints(all, partial)
    allCorrect = "Black";
    partialCorrect = 'white';
    p 'Your current Input colors:';
    p @@playerInput;
    puts "All correct: #{all} #{allCorrect}";
    puts "Partial correct: #{partial} #{partialCorrect}";
    puts "Round: #{@@counter_guess}";
    puts "";
    self.getPlayerInput
  end

  def self.checkWin(all)
    if all === 4
      puts "You Win!";
      puts "Congratulations!";
      return true;
    end
    return false;
  end

  def self.checkRounds(counterGuess)
    if counterGuess === 12
      puts "You Lose!";
      puts "The Riddle is #{@@riddle}"
      return true
    end
    return false;
  end

  def self.playAgain
    puts "Do you wanna play again? Y/N";
    isConfirm = false;
    while !isConfirm
      confirm = gets.chomp.downcase;
      if confirm === "y" || confirm === "n"
        isConfirm = true;
      else
        puts "Please Enter 'Y' or 'N' !!"
      end
    end
    if confirm === "y"
      self.reset
      self.gameStart
    else
      puts "Good Bye!"
      return
    end
  end

  def self.reset
    @@riddle = [];
    @@hint = [];
    @@counter_guess = 0;
  end

end

Mastermind.gameStart
