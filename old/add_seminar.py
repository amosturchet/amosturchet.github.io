# This python script add a new seminar to the html file "SEMINARS.HTML"
#


def get_data():
    #get the data from the user
    #returns a list with the data
    # AUTHOR, TITLE, DATE and TIME of the seminar
    #
    #has command to undo the input
    #
    print "Welcome to the New_Seminar add script \n"
    print 'What is the name of the author? \n'
    author = raw_input()
    print 'What is the title of the seminar? \n'
    title = raw_input()
    print 'On which day the seminar will be given? \n'
    date = raw_input()
    print 'At what time? \n'
    time = raw_input()
    print 'Where? \n'
    time = raw_input()
    print 'Thanks. Would you like this to be add to your seminar.html page? Type 1 for YES and 0 for NO \n'
    action = int(raw_input())
    if action == 0:
        print 'no data will be added to seminars.html \n'
        return 0
    else:
        return [author, title, date, time, location]
    
    
def get_position_top():
    #from the file SEMINARS.HTML (should be in the same folder)
    #retunrs the string that will be modified and its position
    f = open('seminars.html')
    lines = list(f)
    begin = 0
    for i in range(len(lines)):
        if 'add here' in lines[i]:
            begin = i
    if begin < 1:
        raise LookupError('No "add here" found in the html file')
        return 0
        f.close()
    else:
        model = lines[begin-1]
        f.close()
        return [model, begin]
        

def make_new_seminar_top(data,position_top):
    #clean of the comment symbols
    model = position_top[0]
    beg = model.find('<!')
    end = model.find('-->')
    model_clean = model[:beg]+model[beg+4:end]+model[end+3:]
    #insert the data
    rep = model_clean.replace('Who',data[0])
    rep = rep.replace('What',data[1])
    rep = rep.replace('When',data[2])
    rep = rep.replace('Time',data[3])
    #return the string to be inserted
    return rep

def get_position_bottom():
    #from the file SEMINARS.HTML (should be in the same folder)
    #retunrs the string that will be modified and its position
    f = open('seminars.html')
    lines = list(f)
    begin = 0
    for i in range(len(lines)):
        if 'last seminar' in lines[i]:
            begin = i
    if begin < 1:
        raise LookupError('No "add here" found in the html file')
        return 0
        f.close()
    else:
        position = begin-1
        f.close()
        return begin
        
def make_new_seminar_bottom(data,bottom_position):
    
    
    
    
