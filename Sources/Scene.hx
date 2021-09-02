package;

class Scene {
  	public static var active:Scene;
    public var objects:Array<MeshObject> = [];
    public var camera: Camera = new Camera();

  	public function new() {
        active = this;
    }
}