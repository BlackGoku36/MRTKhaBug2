const project = new Project('Empty');

project.addSources('Sources');
project.addShaders('Shaders/**');

resolve(project);
