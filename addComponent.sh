#!/bin/bash

if [ -z "$1" ]; then
  echo "You must supply a Component Name as the first argument"
  exit 1
else
  COMPONENT_NAME="$1"
fi

if [ -z "$2" ]; then
  FOLDER="./$1"
elif [ ! -d "$2" ]; then
  echo "$2 is not a directory"
  exit 1
else
  FOLDER="$2/$1"
fi

INDEX=$FOLDER/index.js

COMPONENT=$FOLDER/$COMPONENT_NAME.js

STYLED=$FOLDER/$COMPONENT_NAME.styled.js

TEST=$FOLDER/$COMPONENT_NAME.test.js

mkdir -p $FOLDER

touch $INDEX $COMPONENT $STYLED $TEST

echo "import $COMPONENT_NAME from './$COMPONENT_NAME'

export default $COMPONENT_NAME" >> $INDEX

echo "import React from 'react'
import PropTypes from 'prop-types'

/**
  * $COMPONENT_NAME component
  *
  * @param  {object} props - props
  *
  * @returns {React.Component} - return react component
  */
const $COMPONENT_NAME = ({}) => {
  return (
    <></>
  )
}

$COMPONENT_NAME.propTypes = {
  
}

export default $COMPONENT_NAME" >> $COMPONENT

echo "import styled from '@emotion/styled'
  ">> $STYLED

echo "import React from 'react'
import { createWithTheme } from '@viacom/dls/utilities/jest-util'
import $COMPONENT_NAME from './$COMPONENT_NAME'

describe('$COMPONENT_NAME', () => {
  it('Should match snapshot', () => {
    const component = createWithTheme(<$COMPONENT_NAME />)

    const tree = component.toJSON()
    expect(tree).toMatchSnapshot()
  })
})" >> $TEST

exit 0