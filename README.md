# RBE Lecture Template 

Template and example assignment for an RBE course at WPI.  Use the provided Docker container to build all assignments.  

## Dependencies

All required LaTeX packages are installed in the container.  
Obtain the [RBE resources](https://github.com/dmflickinger/RBE550resources) project for the bibliography files.


## Build

```sh
mkdir assignments
docker build -t rbe_assignments .
docker run -it --rm -v .:/source -v assignments:/output -v ../rbe_resources:/bib rbe_assignments
```

A completed assignment (in PDF) format is created in the assignments directory.

