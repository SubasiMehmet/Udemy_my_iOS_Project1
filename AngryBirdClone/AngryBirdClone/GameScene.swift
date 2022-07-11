//
//  GameScene.swift
//  AngryBirdClone
//
//  Created by Mehmet Subaşı on 4.04.2022.
//

import SpriteKit
import GameplayKit
import UIKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //var bird2 = SKSpriteNode()
    var bird = SKSpriteNode()
    var box1 = SKSpriteNode()
    var box2 = SKSpriteNode()
    var box3 = SKSpriteNode()
    var box4 = SKSpriteNode()
    var box5 = SKSpriteNode()
    
    var gameStarted = false
    var originalPosition : CGPoint?
    
    var score = 0
    var scoreLabel = SKLabelNode() //Label
    
    
    enum ColliderType: UInt32 {     //Çarpışma için gerekli contactTestBitMask bu şekilde istediği için bu şekilde tanımladık
        case Bird = 1
        case Box = 2
        //Eğer devam ederse UInt32 formatına uygun olması için 1-2-4-8-16 diye devam eder
        /*
        case Ground = 4
        case Tree = 8
        */
        
    }
    
    
    override func didMove(to view: SKView) {
        
        //Kod ile kuşu tanımlamak. Farklı boyutlu telefonlarda kullanım için daha doğru olacaktır.
      /*
        let texture = SKTexture(imageNamed: "bird")
        bird2 = SKSpriteNode(texture: texture)
        bird2.position = CGPoint(x: 0, y: 0)
        bird2.size = CGSize(width: self.frame.width / 16, height: self.frame.height / 10)
        bird2.zPosition = 1
        self.addChild(bird2)
        print("width: \(self.frame.width) and height: \(self.frame.height)")
    */
        
        //PhysicsBody
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame) // fiziksel dünyayı telefon çerçevesiyle kısıtlıyor
        self.scene?.scaleMode = .aspectFit
        
        self.physicsWorld.contactDelegate = self    //Fiziksel kontakları algılamak için
        
        //Bird
        bird = childNode(withName: "bird") as! SKSpriteNode
        
        let birdTexture = SKTexture(imageNamed: "bird") // texture burada kuş boyutu için yaratıldı
        
        bird.physicsBody = SKPhysicsBody(circleOfRadius: birdTexture.size().height / 13)
        bird.physicsBody?.affectedByGravity = false  //yer çekiminden etkilenip etkilenmeyeceği
        bird.physicsBody?.isDynamic = true  //hareket edip etmeyeceği
        bird.physicsBody?.mass = 0.15//kg
        originalPosition = bird.position
        
        
        //ÇARPIŞMA
        bird.physicsBody?.contactTestBitMask = ColliderType.Bird.rawValue   //Bird için çarpışma kategorisi oluşturduk
        bird.physicsBody?.categoryBitMask = ColliderType.Bird.rawValue
        bird.physicsBody?.collisionBitMask = ColliderType.Box.rawValue
        
        
        //Box
        
        let boxTexture = SKTexture(imageNamed: "brick")  //objenin asıl adı
        let size = CGSize(width: boxTexture.size().width / 7.5, height: boxTexture.size().height / 5)
        
        box1 = childNode(withName: "box1") as! SKSpriteNode
        box1.physicsBody = SKPhysicsBody.init(rectangleOf: size)
        box1.physicsBody?.affectedByGravity = true
        box1.physicsBody?.isDynamic = true
        box1.physicsBody?.allowsRotation = true
        box1.physicsBody?.mass = 0.4
        
        box1.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue         //Bu şekilde yaparak kuşla çarpışabileceğini söylüyoruz
        
        box2 = childNode(withName: "box2") as! SKSpriteNode
        box2.physicsBody = SKPhysicsBody.init(rectangleOf: size)
        box2.physicsBody?.affectedByGravity = true
        box2.physicsBody?.isDynamic = true
        box2.physicsBody?.allowsRotation = true
        box2.physicsBody?.mass = 0.4
        
        box2.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        box3 = childNode(withName: "box3") as! SKSpriteNode
        box3.physicsBody = SKPhysicsBody.init(rectangleOf: size)
        box3.physicsBody?.affectedByGravity = true
        box3.physicsBody?.isDynamic = true
        box3.physicsBody?.allowsRotation = true
        box3.physicsBody?.mass = 0.4
        
        box3.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        box4 = childNode(withName: "box4") as! SKSpriteNode
        box4.physicsBody = SKPhysicsBody.init(rectangleOf: size)
        box4.physicsBody?.affectedByGravity = true
        box4.physicsBody?.isDynamic = true
        box4.physicsBody?.allowsRotation = true
        box4.physicsBody?.mass = 0.4
        
        box4.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        box5 = childNode(withName: "box5") as! SKSpriteNode
        box5.physicsBody = SKPhysicsBody.init(rectangleOf: size)
        box5.physicsBody?.affectedByGravity = true
        box5.physicsBody?.isDynamic = true
        box5.physicsBody?.allowsRotation = true
        box5.physicsBody?.mass = 0.4
        
        box5.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        //Label
        
        scoreLabel.fontName = "Helvetica"
        scoreLabel.fontSize = 60
        scoreLabel.text = "0"
        scoreLabel.position = CGPoint(x: 0, y: self.frame.height / 4)
        scoreLabel.zPosition = 2
        self.addChild(scoreLabel)
        
        
        
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {        //didBegin(contact:) Kontakları algılamak için çağırdık
        
        //Dokunma noktasını algılıyoruz
        if contact.bodyA.collisionBitMask == ColliderType.Bird.rawValue || contact.bodyB.collisionBitMask == ColliderType.Bird.rawValue {
            
            score += 1
            scoreLabel.text = String(score)
        }
        
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        //Dokundukça kuşun uçması. Flappy Bird
        /*
        bird.physicsBody?.applyImpulse(CGVector(dx: 50, dy: 150))   //Kuşa impulse uygulamak
        bird.physicsBody?.affectedByGravity = true                  //Dokununca yerçekimi başlar
        */
        
        //Kuşu tutup sürüklemek
        if gameStarted == false {           //Oyun başladı mı?
            if let touch = touches.first{               //İlk dokunulan nokta
                
                let touchLocation = touch.location(in: self)        //
                let touchNodes = nodes(at: touchLocation)           //dokunulan noktadaki Node'u al
                
                if touchNodes.isEmpty == false {
                    for node in touchNodes {
                        
                        if let sprite = node as? SKSpriteNode{      //dokunulan node'u SKSpriteNode olarak al
                            if sprite == bird{                      //O node kuşa eşit mi?
                                bird.position = touchLocation       //Eşitse kuşun yerini değiştir
                            }
                        }
                    }
                }
            }
        }
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        //touchesbegan ile tamamen aynı. Dokunulduğunda hareketi devam ettirmesi için buraya da yazılır
        if gameStarted == false {
            if let touch = touches.first{
                
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    for node in touchNodes {
                        
                        if let sprite = node as? SKSpriteNode{
                            if sprite == bird{
                                bird.position = touchLocation
                            }
                        }
                    }
                }
            }
        }
        
        
        
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        if gameStarted == false {
            if let touch = touches.first{
                
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    for node in touchNodes {
                        
                        if let sprite = node as? SKSpriteNode{
                            if sprite == bird{
                                            //Kuşun fırlatılması
                                let dx = touchLocation.x - originalPosition!.x
                                let dy = touchLocation.y - originalPosition!.y
                                
                                let impulse = CGVector(dx: -dx, dy: -dy)
                                bird.physicsBody?.applyImpulse(impulse)
                                bird.physicsBody?.affectedByGravity = true
                                
                                gameStarted = true
                                
                            }
                        }
                    }
                }
            }
        }
        
        
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
       
    }
    
    
    override func update(_ currentTime: TimeInterval) {  //Ekran her değiştiğinde bu fonksiyon sürekli olarak
        // Called before each frame is rendered
        
        if let birdPhysicsBody = bird.physicsBody {         //Sadece optionaldan çıkartmak için
            
            if birdPhysicsBody.velocity.dx <= 0.1 && birdPhysicsBody.velocity.dy <= 0.1 && birdPhysicsBody.angularVelocity <= 0.1 && gameStarted == true {
                
                //Ayaları sıfırlamak
                birdPhysicsBody.affectedByGravity = false
                birdPhysicsBody.velocity = CGVector(dx: 0, dy: 0)
                birdPhysicsBody.angularVelocity = 0
                bird.zPosition = 1
                bird.position = originalPosition!
                
                score = 0
                scoreLabel.text = "0"
                
                gameStarted = false
                
                
            }
            
        }
        
        
    }
}
