# bin.jl

In this file there are all the useful functions that should be used to read a bin potree.

Thoose functions are tested but in order to be fully functional they need to be revised.

## !BUG

in fact the function **decodePoint** decodes everything as suggested at hte end of [pointDecoding](https://github.com/PropellerAero/potree-propeller-private/blob/master/docs/file_format.md) but every bin file has a different bounding box instead **bin2points** passes to the decoder the bounding box of the cloud.
Sometimes the resultant points are the same but as the Potree grows the points change their coordinates significally.

Here's an example using the stair potree stored in the potree folder:
![LasBin.JPG](https://www.dropbox.com/s/jqfgho6i854p3r3/LasBin.JPG?dl=0&raw=1)
As you can see the circled parts differ.

By the way that's a minor issue because this "bug" could be fixed in various way.
In this package there's also a test file that helps to check wheter further changes resolve the problem.

## ToDo

- Fix the decoding
- Parse RGB to LasIO.N0f16
- As the previous points are fixed just create a trie with the previous infos

## Main Interface

```@docs
Potree.decodePoint
```

```@docs
Potree.binToPointsUgly
```

```@docs
Potree.bin2points
```

```@docs
Potree.bin2rgb
```
```@docs
Potree.bin2pointcloud
```