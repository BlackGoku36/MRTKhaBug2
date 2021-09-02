package;

import kha.Image;

class MeshObject {
    public var mesh:Mesh;
    public var texture:Image;
    // public var transform:Transform;

    public function new(mesh:Mesh, texture:Image/*, transform:Transform*/) {
        this.mesh = mesh;
        this.texture = texture;
        // this.transform = transform;
    }
}