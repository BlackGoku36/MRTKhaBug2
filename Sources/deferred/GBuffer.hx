package deferred;

import kha.System;
import kha.Image;
import kha.math.FastMatrix4;
import kha.graphics4.ConstantLocation;
import kha.Shaders;
import kha.graphics4.PipelineState;
import kha.graphics4.VertexStructure;
import kha.Framebuffer;

class GBuffer {
    
    public static var pipeline:PipelineState;
    static var cameraProjectionID:ConstantLocation;
    static var cameraViewID:ConstantLocation;
    static var modelMatrixID:ConstantLocation;
    static var passID:ConstantLocation;

    public static var albedoImage:Image;
    public static var normalImage:Image;
    // public static var posImage:Image;
    // public static var depthImage:Image;

    public static function init() {

        var structure = new VertexStructure();
        structure.add("pos", Float3);
        structure.add("nor", Float3);
        structure.add("texcoord", Float2);

        pipeline = new PipelineState();
        pipeline.inputLayout = [structure];
        pipeline.vertexShader = Shaders.shade_vert;
        pipeline.fragmentShader = Shaders.shade_frag;
        pipeline.depthWrite = true;
        pipeline.depthMode = Less;
        pipeline.cullMode = Clockwise;
        pipeline.compile();

        passID = pipeline.getConstantLocation("pass");
        cameraProjectionID = pipeline.getConstantLocation("P");
        cameraViewID = pipeline.getConstantLocation("V");
        modelMatrixID = pipeline.getConstantLocation("M");

        albedoImage = Image.createRenderTarget(System.windowWidth(), System.windowHeight());
        normalImage = Image.createRenderTarget(System.windowWidth(), System.windowHeight());
        // posImage = Image.createRenderTarget(System.windowWidth(), System.windowHeight());
        // depthImage = Image.createRenderTarget(System.windowWidth(), System.windowHeight());
        
    }
    
    public static function renderAlbedo() {
        var g4 = albedoImage.g4;
        g4.begin([normalImage]);
        g4.clear(Black, 1);
        g4.setPipeline(pipeline);
        for (obj in Scene.active.objects){
            g4.setVertexBuffer(obj.mesh.vertexBuffer);
            g4.setIndexBuffer(obj.mesh.indexBuffer);
            g4.setInt(passID, 0);
            g4.setMatrix(cameraProjectionID, Scene.active.camera.projection);
            g4.setMatrix(cameraViewID, Scene.active.camera.view);
            g4.setMatrix(modelMatrixID, FastMatrix4.identity());
            g4.drawIndexedVertices();
        }
        g4.end();
    }

    public static function renderNormal() {
        var g4 = normalImage.g4;
        g4.begin();
        g4.clear(White);
        g4.setPipeline(pipeline);
        for (obj in Scene.active.objects){
            g4.setVertexBuffer(obj.mesh.vertexBuffer);
            g4.setIndexBuffer(obj.mesh.indexBuffer);
            g4.setInt(passID, 1);
            g4.setMatrix(cameraProjectionID, Scene.active.camera.projection);
            g4.setMatrix(cameraViewID, Scene.active.camera.view);
            g4.setMatrix(modelMatrixID, FastMatrix4.identity());
            g4.drawIndexedVertices();
        }
        g4.end();
    }
    // public static function renderPos() {
    //     var g4 = posImage.g4;
    //     g4.begin();
    //     g4.clear(Black);
    //     g4.setPipeline(pipeline);
    //     for (obj in Scene.active.objects){
    //         g4.setVertexBuffer(obj.mesh.vertexBuffer);
    //         g4.setIndexBuffer(obj.mesh.indexBuffer);
    //         g4.setInt(passID, 2);
    //         g4.setMatrix(cameraProjectionID, Scene.active.camera.projection);
    //         g4.setMatrix(cameraViewID, Scene.active.camera.view);
    //         g4.setMatrix(modelMatrixID, FastMatrix4.identity());
    //         g4.drawIndexedVertices();
    //     }
    //     g4.end();
    // }

    // public static function renderDepth() {
    //     var g4 = depthImage.g4;
    //     g4.begin();
    //     g4.clear(Black);
    //     g4.setPipeline(pipeline);
    //     for (obj in Scene.active.objects){
    //         g4.setVertexBuffer(obj.mesh.vertexBuffer);
    //         g4.setIndexBuffer(obj.mesh.indexBuffer);
    //         g4.setInt(passID, 3);
    //         g4.setMatrix(cameraProjectionID, Scene.active.camera.projection);
    //         g4.setMatrix(cameraViewID, Scene.active.camera.view);
    //         g4.setMatrix(modelMatrixID, FastMatrix4.identity());
    //         g4.drawIndexedVertices();
    //     }
    //     g4.end();
    // }

}