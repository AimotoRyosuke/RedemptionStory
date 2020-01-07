class Category < ActiveHash::Base
  self.data = [
      {id: 1, name: "誕生日"}, 
      {id: 2, name: "出産"}, 
      {id: 3, name: "デート"}, 
      {id: 4, name: "結婚"},  
      {id: 5, name: "クリスマス"},
      {id: 6, name: "入学式"},
      {id: 7, name: "卒業式"},
      {id: 8, name: "仕事"},
      {id: 9, name: "ハロウィン"},
      {id: 10, name: "日常"},
      {id: 11, name: "旅行"},
      {id: 12, name: "引越し"},
      {id: 13, name: "記念日"},
      {id: 14, name: "その他"}
  ]
end