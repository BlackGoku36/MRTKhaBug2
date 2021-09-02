package deferred;

import kha.graphics4.TextureUnit;
import kha.graphics4.IndexBuffer;
import kha.graphics4.VertexBuffer;
import kha.System;
import kha.Image;
import kha.math.FastMatrix4;
import kha.graphics4.ConstantLocation;
import kha.Shaders;
import kha.graphics4.PipelineState;
import kha.graphics4.VertexStructure;
import kha.Framebuffer;

class Renderer {

    public static var renderImage:Image;
    static var pipeline: PipelineState;
	static var vertexBuffer: VertexBuffer;
	static var indexBuffer: IndexBuffer;
	static var albedo: TextureUnit;
	static var normals: TextureUnit;
	// static var depth: TextureUnit;
	// static var pos: TextureUnit;

    public static function init() {
        TextureViewer.init();
        GBuffer.init();
        renderImage = Image.createRenderTarget(System.windowWidth(), System.windowHeight());
        var structure = new VertexStructure();
        structure.add("pos", Float2);

        pipeline = new PipelineState();
        pipeline.inputLayout = [structure];
        pipeline.vertexShader = Shaders.light_vert;
        pipeline.fragmentShader = Shaders.light_frag;
        pipeline.compile();

        vertexBuffer = new VertexBuffer(4, structure, StaticUsage);
        var vertices = vertexBuffer.lock();
        vertices.set(0, -1); vertices.set(1, -1);
        vertices.set(2, 1); vertices.set(3, -1);
        vertices.set(4, -1); vertices.set(5, 1);
        vertices.set(6, 1); vertices.set(7, 1);
        vertexBuffer.unlock();

        indexBuffer = new IndexBuffer(6, StaticUsage);
        var indices = indexBuffer.lock();
        indices.set(0, 0); indices.set(1, 1); indices.set(2, 2);
        indices.set(3, 1); indices.set(4, 3); indices.set(5, 2);
        indexBuffer.unlock();

        albedo = pipeline.getTextureUnit("albedo");
        normals = pipeline.getTextureUnit("normals");
        // depth = pipeline.getTextureUnit("depth");
        // pos = pipeline.getTextureUnit("pos");
    }

    public static function render(g:Framebuffer) {
        GBuffer.renderAlbedo();
        // GBuffer.renderNormal();
        // GBuffer.renderDepth();
        // GBuffer.renderPos();
        var g4 = g.g4;
        g4.begin();
        g4.clear(Black);
        g4.setPipeline(pipeline);
        g4.setVertexBuffer(vertexBuffer);
        g4.setIndexBuffer(indexBuffer);
        g4.setTexture(albedo, GBuffer.albedoImage);
        g4.setTexture(normals, GBuffer.normalImage);
        // g.setTexture(pos, GBuffer.posImage);
        // g.setTextureDepth(depth, GBuffer.depthImage);
        g4.drawIndexedVertices();
        g4.end();
        // g.g4.begin();
        // g.g4.clear(Green);
        // TextureViewer.render(g.g4, renderImage, false, -1, 0, 1, 1);
        // g.g4.end();
    }

}