package;

import kha.arrays.Uint32Array;
import kha.arrays.Float32Array;

class Cube {
    public var vertices:Float32Array;
    public var indices:Uint32Array;
    public var normals:Float32Array;
    public var uvs:Float32Array;

    var index = 0;
    var vertID = 0;
    var norID = 0;
    var uvID = 0;

    public function new() {
        vertices = new Float32Array(108);
        normals = new Float32Array(108);
        indices = new Uint32Array(36);
        uvs = new Float32Array(72);
        addTopFace(0, 0, 0);
        addBottomFace(0, 0, 0);
        addFrontFace(0, 0, 0);
        addBackFace(0, 0, 0);
        addLeftFace(0, 0, 0);
        addRightFace(0, 0, 0);
    }

    inline function addTopFace(x:Int, y:Int, z:Int) {
        addVertice(x, y+1, z+1);
        addVertice(x+1, y+1, z);
        addVertice(x, y+1, z);

        addVertice(x, y+1, z+1);
        addVertice(x+1, y+1, z+1);
        addVertice(x+1, y+1, z);

        addNormal(0, 1, 0);

        addIndices();
        //TODO: Add UVs
    }
    inline function addBottomFace(x:Int, y:Int, z:Int) {
        addVertice(x+1, y, z+1);
        addVertice(x, y, z+1);
        addVertice(x, y, z);

        addVertice(x+1, y, z+1);
        addVertice(x, y, z);
        addVertice(x+1, y, z);

        addNormal(0, -1, 0);

        addIndices();
        //TODO: Add UVs
    }
    inline function addBackFace(x:Int, y:Int, z:Int) {
        addVertice(x, y, z);
        addVertice(x, y, z+1);
        addVertice(x, y+1, z+1);

        addVertice(x, y, z);
        addVertice(x, y+1, z+1);
        addVertice(x, y+1, z);

        addNormal(-1, 0, 0);

        addIndices();
        //TODO: Add UVs
    }
    inline function addFrontFace(x:Int, y:Int, z:Int) {
        addVertice(x+1, y, z+1);
        addVertice(x+1, y, z);
        addVertice(x+1, y+1, z);
        
        addVertice(x+1, y, z+1);
        addVertice(x+1, y+1, z);
        addVertice(x+1, y+1, z+1);

        addNormal(1, 0, 0);

        addIndices();
        //TODO: Add UVs
    }
    inline function addLeftFace(x:Int, y:Int, z:Int) {
        addVertice(x+1, y, z);
        addVertice(x, y, z);
        addVertice(x, y+1, z);

        addVertice(x+1, y, z);
        addVertice(x, y+1, z);
        addVertice(x+1, y+1, z);

        addNormal(0, 0, -1);

        addIndices();
        //TODO: Add UVs
    }
    inline function addRightFace(x:Int, y:Int, z:Int) {
        addVertice(x, y, z+1);
        addVertice(x+1, y, z+1);
        addVertice(x+1, y+1, z+1);

        addVertice(x, y, z+1);
        addVertice(x+1, y+1, z+1);
        addVertice(x, y+1, z+1);

        addNormal(0, 0, 1);

        addIndices();
        //TODO: Add UVs
    }

    inline function addVertice(x:Float, y:Float, z:Float) {
        vertices[vertID] = x;
        vertices[vertID+1] = y;
        vertices[vertID+2] = z;
        vertID += 3;
    }

    inline function addNormal(x:Float, y:Float, z:Float) {
        for ( _ in 0...6){
            normals[norID] = x;
            normals[norID+1] = y;
            normals[norID+2] = z;
            norID += 3;
        }
    }

    inline function addUV(x:Float, y:Float) {
        uvs[uvID] = x;
        uvs[uvID+1] = y;
        uvID += 2;
    }

    inline function addIndices() {
        for ( _ in 0...6){
            indices[index] = index;
            index += 1;
        }
    }
}