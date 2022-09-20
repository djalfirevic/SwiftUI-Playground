//
//  MagicWithSpriteKit.swift
//  ProSwiftUI
//
//  Created by Paul Hudson on 03/09/2022.
//

import SpriteKit
import SwiftUI

extension MagicWithSpriteKit {
    class WaterScene: SKScene {
        private let spriteNode = SKSpriteNode()
        var image: UIImage?
        
        let waterShader = SKShader(source: """
        void main() {
            float speed = u_time * u_speed;
        
            v_tex_coord.x += cos((v_tex_coord.x + speed) * u_frequency) * u_strength;
            v_tex_coord.y += sin((v_tex_coord.y + speed) * u_frequency) * u_strength;
        
            gl_FragColor = texture2D(u_texture, v_tex_coord);
        }
        """)
        
        override func sceneDidLoad() {
            backgroundColor = .clear
            scaleMode = .resizeFill

            spriteNode.shader = waterShader
            addChild(spriteNode)
        }
        
        func updateTexture() {
            guard view != nil else { return }
            guard let image else { return }

            let texture = SKTexture(image: image)
            spriteNode.texture = texture
            spriteNode.size = texture.size()
            spriteNode.position.x = frame.midX
            spriteNode.position.y = frame.midY
        }

        override func didMove(to view: SKView) {
            updateTexture()
        }
    }
    
    struct WaterEffect<Content: View>: View {
        @State private var scene = WaterScene()
        @Environment(\.displayScale) var displayScale

        var speed: Double
        var strength: Double
        var frequency: Double
        @ViewBuilder var content: () -> Content
        
        var body: some View {
            let renderer = ImageRenderer(content: content())
            renderer.scale = displayScale
            
            let image = renderer.uiImage
            let size = image?.size ?? .zero
            
            scene.waterShader.uniforms = [
                SKUniform(name: "u_speed", float: Float(speed)),
                SKUniform(name: "u_strength", float: Float(strength) / 20.0),
                SKUniform(name: "u_frequency", float: Float(frequency))
            ]
            
            scene.image = image
            scene.updateTexture()
            
            return SpriteView(scene: scene, options: .allowsTransparency)
                .frame(width: size.width, height: size.height)
        }
    }
}

struct MagicWithSpriteKit: SelfCreatingView {
    @State private var text = "Hello"
    @State private var speed = 0.5
    @State private var strength = 0.5
    @State private var frequency = 5.0

    var body: some View {
        VStack {
            WaterEffect(speed: speed, strength: strength, frequency: frequency) {
                Circle()
                    .fill(.red)
                    .frame(width: 150, height: 150)
                    .padding()
                    .overlay(Circle().stroke(.red, lineWidth: 4))
                    .overlay(Text(text).font(.title).foregroundColor(.white))
                    .padding()
            }

            TextField("Enter a message", text: $text)
                .textFieldStyle(.roundedBorder)
                .padding()

            LabeledContent("Speed") {
                Slider(value: $speed)
            }

            LabeledContent("Strength") {
                Slider(value: $strength)
            }

            LabeledContent("Frequency") {
                Slider(value: $frequency, in: 5...25)
            }
        }
        .padding()
    }
}

struct MagicWithSpriteKit_Previews: PreviewProvider {
    static var previews: some View {
        MagicWithSpriteKit()
    }
}
