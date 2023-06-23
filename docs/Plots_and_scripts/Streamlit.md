# Streamlit data visualization

## Description

Streamlit is an open-source Python library that makes it easy to create and share beautiful, custom web apps for machine learning and data science. In just a few minutes you can build and deploy powerful data apps.

### Installation

Streamlit can be installed with `conda` (or `[micro]mamba`) and `pip`, as follows:

===+ "Conda"

    Create environment and activate:
    
    ```sh
    # Create ENV
    conda create --name streamlit_app python=3.5 pip

    # Activate env
    conda activate strealit_app
    ```

=== "Mamba"

    Create environment and activate:
    
    ```sh
    # Create ENV
    mamba create --name streamlit_app python=3.5 pip

    # Activate env
    mamba activate strealit_app
    ```

Download package:

    pip install streamlit

#### Demo

    streamlit hello

<iframe loading="lazy" src="https://doc-mpa-hello.streamlit.app/?embed=true" height="500" width=100% class="cloud_Iframe__xSBvF" allow="camera;clipboard-read;clipboard-write;"></iframe>

## Key concepts

### Running the app

Streamlit creates a local server as soon as you run the script with the following command:

    streamlit run your_script.py [-- script args]

This command will open a new tab in your default web browser.

### Build the app

Let's imagine that your_script.py is like a canvas. In this canvas you can build the components as you prefer.

??? example "Components"
    ===+ "Layout"

        These components are necessary to structure the app. We have 5 layout components:

        - `st.container`: It divides the canvas in containers

            ```py
            import streamlit as st

            cont1 = st.container()

            with cont1:
                st.write("This is a text on container 1")
            
            ## is equivalent to: 

            cont1.write("This is another text on container 1")
            ```
        - `st.sidebar` : It allows to add object to the sidebar.

            ```py
            import streamlit as st

            with st.sidebar:
                st.image('url/to/image.png')
            
            ## is equivalent to:

            st.sidebar.image("url/to/image.png")
            ```

        - `st.columns` : It divides the container or the canvas in columns.
            
            ```py
            import steamlit st

            col1, col2 = st.columns(2)

            ## or you can specify the ratio and the gap

            col1, col2 = st.columns([0.3, 0.7], gap='small')

            with col1:
                st.write("this is column 1")

            col2.write("this is column 2")
            ```

        - `st.expander` : it adds an expander in the canva

            ```py
            import streamlit as st

            with st.expander("This is the title of the expander", expanded=True)
                st.write("this is the content of the expander")
            ``` 

    === "Text"

        In Streamlit there are several ways of writing text in the app:

        - `st.text` : Write fixed-width and preformatted text.
        - `st.markdown` :  string formatted as Markdown, it can also read html string (although it is considered unsafe)
            
            ```py
            import streamlit as st

            st.markdown(
                    """
                        <h2>This is heading 2</h2>
                        <p> 
                        This is paragraph 1 
                        </p>
                    """,
                    allow_unsafe_html=True
                )

            ```
        - `st.code` : renders code as text
        - `st.latex` : reads latex syntax, useful for math expressions.
        - `st.divider` : adds a horizontal line that divides the area of the container/column etc
        - `st.title`, `st.header`, `st.caption`, `st.subheader` : self-explanatory. 


    === "Data and Charts"

        Streamlit is optimize for visualize Data quickly, interactively, and from multiple different angles. You can use several functions:

        - *Data*
            - `st.dataframe` : it reads and renders a Pandas dataframe
            - `st.metric` : it returns a KPI specified by the user
            - `st.table` : it returns a table
            - `st.json` : it returns a box with a json that can be copied by the user at certain level.
        
        Streamlite has also built in wrapper for several package used to plot dynamically the data, some of them are: 

        - *Charts*
            - `st.line_chart`, `st.area_chart`, `st.bar_chart`
            - `st.pyplot` : wrapper of matplotlib pyplot. 
            - `st.plotly` : wrapper of plotly, create interactive and dynamic plots.


    === "Input"

        Streamlit let you go through your data dynamically. This can be done through the use of button, selectors, several types of inputs or via file uploader. 

        - `st.button`: Simple button that return a Boolean (False, True) if clicked or not - can be used as a condition in if statements.
        - `st.selectbox`: Dropdown menu that can be selected. Returns the string of the option selected.
        - `st.slider`, `st.checkbox`.


    === "Message status"

        Streamlit allows to return messages to the user in some specific cases. i.e. if the user needs to produce a plot by selecting some data, the message should appear only if the selection is not made.

        ```py
        import streamlit as st

        selection = st.selectbox("This is the title of the selectbox",  ("Select Option", "Option0", "option1", "option2"))

        if selection == "Select Option":

            st.info("please select an option")
        else:
            st.markdown(
                """
                You selected {option}
                """.format(option=selection)
                )
        ```

        Types of message statuses:
        - `st.info` : Returns a blue box with some info.
        - `st.error` : Returns a red box with error info.
        - 'st.warning` : Returns a yellow box.
        - `st.success`: Returns a green box.

### Examples

- [Gallery](https://streamlit.io/gallery)

### Documentation

- [Streamlit Documentation](https://docs.streamlit.io/library/get-started)

### Source

- Federica Brando
