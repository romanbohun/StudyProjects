import Foundation

protocol Renderer
{
    var whatToRenderAs: String { get }
}

class Shape : CustomStringConvertible
{
    var name: String = ""
    
    private let renderer: Renderer
    init(_ renderer: Renderer) {
        self.renderer = renderer
    }
    
    var description: String {
        return "Drawing \(name) as \(renderer.whatToRenderAs)"
    }
}

class Triangle : Shape
{
    override init(_ renderer: Renderer)
    {
        super.init(renderer)
        name = "Circle"
    }
}

class Square : Shape
{
    override init(_ renderer: Renderer)
    {
        super.init(renderer)
        name = "Square"
    }
}

class RasterRenderer: Renderer {
    
    var whatToRenderAs: String {
        "pixels"
    }
}

class VectorRenderer: Renderer {
    
    var whatToRenderAs: String {
        "lines"
    }
}
