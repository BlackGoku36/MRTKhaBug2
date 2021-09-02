package;

import deferred.Renderer;
import kha.Assets;
import kha.Framebuffer;
import kha.Scheduler;
import kha.System;

class Main {

	static function init() {
		var cubemesh = new Cube();
		var scene = new Scene();
		var cubeObject = new MeshObject(new Mesh(cubemesh.vertices, cubemesh.indices, cubemesh.normals, cubemesh.uvs), null);
		scene.objects.push(cubeObject);
		Renderer.init();
	}

	static function update(): Void {
	}

	static function render(framebuffer: Framebuffer): Void {
		Renderer.render(framebuffer);
	}

	public static function main() {
		System.start({title: "Kha", width: 800, height: 600}, function (_) {
			// Just loading everything is ok for small projects
			Assets.loadEverything(function () {
				init();
				Scheduler.addTimeTask(function () { update(); }, 0, 1 / 60);
				System.notifyOnFrames(function (framebuffers) { render(framebuffers[0]); });
			});
		});
	}
}
