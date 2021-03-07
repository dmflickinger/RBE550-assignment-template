# RBE Assignment Template 

Template and example assignment for an RBE course at WPI.  Use the provided Docker container to build all assignments.  

## Dependencies

All required LaTeX packages are installed in the container.  
Obtain the [RBE resources](https://github.com/dmflickinger/RBE550resources) project for the bibliography files.


## Build

```sh
mkdir assignmentSlides
podman build -t rbe_assignment .
podman run -it --rm -v .:/source -v assignmentSlides:/output -v ../rbe_resources:/bib rbe_assignment
```

A completed assignment (in PDF) format is created in the assignmentSlides directory.
