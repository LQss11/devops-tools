# Search (\c is for case insensitive) type n or N to move forward or backward
/something\c
# Show line numbers
:set nu
# Go to specific line
:15
# Copy paste
yy -> p
# Cut/Delete line
dd
# Delete 1000
1000dd
# Open new tab (use those to switch gt gT or 4gt for forth tab)
:tabnew
# Split horizontal and vertical
# use ctrl + w then hjkl to move between 
:sp filename
:vsp filename

# Change file
:e! filepath


# Open 2 or + kubectl edit at a time
# Navigate with ctrl + w and then arrows
vi
:vsp
:term kubectl edit svc/kubernetes 
# Or directly through vsp 
:vsp | term kubectl edit svc/kubernetes