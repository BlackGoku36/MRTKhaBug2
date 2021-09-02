package;

import kha.graphics4.IndexBuffer;
import kha.graphics4.VertexBuffer;
import kha.graphics4.VertexStructure;
import kha.arrays.Uint32Array;
import kha.arrays.Float32Array;

class Mesh {
    var vertices:Float32Array;
    var indices:Uint32Array;
    var normals:Float32Array;
    var uvs:Float32Array;

    public var vertexStructure:VertexStructure;
    public var vertexBuffer:VertexBuffer;
    public var indexBuffer:IndexBuffer;

    public function new(vertices:Float32Array, indices:Uint32Array, normals:Float32Array, uvs:Float32Array) {
        this.vertices = vertices;
        this.indices = indices;
        this.normals = normals;

        this.vertexStructure = new VertexStructure();
        this.vertexStructure.add("pos", Float3);
        this.vertexStructure.add("nor", Float3);
        this.vertexStructure.add("texcoord", Float2);

        vertexBuffer = new VertexBuffer(vertices.length, this.vertexStructure, StaticUsage);
        var buffer = vertexBuffer.lock();
        for (i in 0...Std.int(vertices.length/3)){
            buffer.set(i * 8 + 0, vertices[i * 3 + 0]);
            buffer.set(i * 8 + 1, vertices[i * 3 + 1]);
            buffer.set(i * 8 + 2, vertices[i * 3 + 2]);
            buffer.set(i * 8 + 3, normals[i * 3 + 0]);
            buffer.set(i * 8 + 4, normals[i * 3 + 1]);
            buffer.set(i * 8 + 5, normals[i * 3 + 2]);
            buffer.set(i * 8 + 6, uvs[i * 2 + 0]);
            buffer.set(i * 8 + 7, uvs[i * 2 + 1]);
        }
        vertexBuffer.unlock();

        indexBuffer = new IndexBuffer(indices.length, StaticUsage);
        var ibuffer = indexBuffer.lock();
        for (i in 0...indices.length){
            ibuffer.set(i, indices[i]);
        }
        indexBuffer.unlock();
    }
}